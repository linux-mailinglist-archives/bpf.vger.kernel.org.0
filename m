Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32D8282CDB
	for <lists+bpf@lfdr.de>; Sun,  4 Oct 2020 21:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgJDTCP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Oct 2020 15:02:15 -0400
Received: from mail-vk1-f175.google.com ([209.85.221.175]:41533 "EHLO
        mail-vk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgJDTCP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Oct 2020 15:02:15 -0400
Received: by mail-vk1-f175.google.com with SMTP id u204so906395vkb.8
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2020 12:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=L4tKCL/F7MTFhuzy380CIJTgcgB7raUFVbAGWEwfkJA=;
        b=HkR+Wdn3vOQjwDuZISKi2tpbulJm3GzVJAE6ssX/Fh2Re9pK4c8ZKh4UJ+L+u5wVM4
         sTEZHTTbWvHaTuyFlblxe+qxYLR6Cw9eLBAtkVNFlEEKe6AO1o+sp1HloJFr4knl+GiM
         PhuZnbBr0ckLf5yXZNZw/0v9qAYt/D/MPmxgxddwFrbKN2FOmZgRC/yPNZ8ExXjtRLRl
         TpD63UndfB3iPZMz/IsUFmEsQfFVNQhlcrPozAyxsLsz4f4/HyMCcLOZtOx0RAHr7LCt
         ArPgJ9e50GcpIGzWFQjds8dSZsC5DSEvIlWXnVlASMArpj8/LFJUizZpj5H/fHd86oVD
         yJ8Q==
X-Gm-Message-State: AOAM533A6toxIasmWNfyY/6a5P1BjJcHZmDIIA28hmCd0hMoY9XKF4Np
        63sw3KDMfXZPuGflBW+QldZHBJ4UQBoF5/EjWJPG181iuvNe3JEo
X-Google-Smtp-Source: ABdhPJzprxL7o3e5aUVhJ/aiVDA2rqNAOpVuF1Uhlm2WyrTnUOOe2RbC9gKxnlfmnWrjegjlPoT3jmMnuIGbWVB3wxc=
X-Received: by 2002:a1f:9e01:: with SMTP id h1mr5133493vke.22.1601838133320;
 Sun, 04 Oct 2020 12:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601414174.git.daniel@iogearbox.net> <7567cc9972d9c397346ecf27df57658b1f946eea.1601414174.git.daniel@iogearbox.net>
In-Reply-To: <7567cc9972d9c397346ecf27df57658b1f946eea.1601414174.git.daniel@iogearbox.net>
From:   Luigi Rizzo <rizzo@iet.unipi.it>
Date:   Sun, 4 Oct 2020 21:02:02 +0200
Message-ID: <CA+hQ2+hqMpmwHRxbeu20QBzC67BQ4UK+JvFV16JtnZ66+sHpCA@mail.gmail.com>
Subject: bpf_program__set_attach_target(prog, 0, "foo") cannot possibly work ?
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,
I am trying to use

   bpf_program__set_attach_target(prog,  0, "foo")

to override the attach point for a bpf program, and it seems that
it cannot possibly work because the function depends on
prog->obj->btf_vmlinux being !NULL.

The only place in libbpf that sets btf_vmlinux is this:

  2495 static int bpf_object__load_vmlinux_btf(struct bpf_object *obj)
  ...
  2517         obj->btf_vmlinux = libbpf_find_kernel_btf();

and this is only called within the function below, which also clears
the field once done.

  5890 int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
  ...
  5911         err = err ? : bpf_object__load_vmlinux_btf(obj);
  ...
  5917         btf__free(obj->btf_vmlinux);

I don't know exactly what is the plan with that field, hence what
is the best way to fix the problem. I can suggest a couple below:


index 7253b833576c..28288d4c992b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9128,10 +9128,18 @@ int bpf_program__set_attach_target(struct
bpf_program *prog,
        if (attach_prog_fd)
                btf_id = libbpf_find_prog_btf_id(attach_func_name,
                                                 attach_prog_fd);
-       else
-               btf_id = __find_vmlinux_btf_id(prog->obj->btf_vmlinux,
+       else {
+               struct btf *btf = prog->obj->btf_vmlinux;
+
+               if (!btf)
+                       btf = libbpf_find_kernel_btf();
+
+               btf_id = __find_vmlinux_btf_id(btf,
                                               attach_func_name,
                                               prog->expected_attach_type);
+               if (!prog->obj->btf_vmlinux)
+                       btf_free(btf);
+       }

        if (btf_id < 0)
                return btf_id;


or possibly even simpler

index 7253b833576c..a9870e9dc67a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9128,10 +9128,14 @@ int bpf_program__set_attach_target(struct
bpf_program *prog,
        if (attach_prog_fd)
                btf_id = libbpf_find_prog_btf_id(attach_func_name,
                                                 attach_prog_fd);
-       else
-               btf_id = __find_vmlinux_btf_id(prog->obj->btf_vmlinux,
-                                              attach_func_name,
+       else {
+               struct btf *btf = libbpf_find_kernel_btf();
+
+               btf_id = __find_vmlinux_btf_id(btf, attach_func_name,
                                               prog->expected_attach_type);
+               if (btf)
+                       btf_free(btf);
+       }

        if (btf_id < 0)
                return btf_id;


---

Does the above make sense ?

cheers
luigi
