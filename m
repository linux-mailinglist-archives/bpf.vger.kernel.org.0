Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAFC1BCB92
	for <lists+bpf@lfdr.de>; Tue, 28 Apr 2020 20:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbgD1S6C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Apr 2020 14:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729770AbgD1S6B (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Apr 2020 14:58:01 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124AAC03C1AB
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2020 11:58:01 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id v38so10927276qvf.6
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2020 11:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b0L1ktGzrK0LQZO0rEs01n6+sdiXlGW1/AnA9H8zYJ8=;
        b=EK+XhIuq319T0HbtQOuX5rKgbseo+ukv14s9HGVjgesdzfwobu5iTH3ciZIqJQlMeb
         gLSNDQQiV6vffU8us5O1B841SAEjlDk50wU2Coyqp/PPkVjW9OgP1+gbNpDWVSp/l5cr
         cPvMb5VONdkNOfUEGnQFeRoHHPBPknD/dtM7Q75XVbxnoiifDlZxnZCUnYvWu1oGOyqD
         pIcQTubcX5F3CK2uL1gty9l04nZJ/4D8vBXNhVD78APaQb3uJ2Vu/IShaPL9RJLyqwBm
         Bg/MDGfsJAPlT+FPqGWAtJonx8DbwugH5s6x2BteR/CquCXZM4n2J+yy9sirLFK/GpLy
         t+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b0L1ktGzrK0LQZO0rEs01n6+sdiXlGW1/AnA9H8zYJ8=;
        b=VAKYhz+X/TzaoWtFCB/EZIx8gePhmtT54mHEFw4lirhP0w9wIsu0JwSWQG1K6KsN+f
         GGmZ/qs2p1KVB50v89HHB6J47L8xNZQfe9wTAIXSjiSUgILNxfl8RXocsI9R3w88Lzjp
         9WipIUagjfhm3V3a5tQhhP6Trw1J3kIBsastZr5NZYUYpcAqR8SscEL0MK9aoHp8dHY6
         jqDoSQCMDhF9s5qucliBw0SC35jmIAx1p97uOB4OiJiq8IZZqdv9OlxlM70j6xQn4oW3
         HI/S5fZpMTBxFLYuu++RfFlgGL92Gb9Urc7+A/rh8bp0gNn7hbnaSk9o5tQ3vvgfC946
         XU0A==
X-Gm-Message-State: AGi0Pua222g1H48UrZuEFG+JMxNmQ1yEHEqe8Q6BTtRUtQ3DndmtDA7p
        +CR6E8EVB+Or9eZ6VKFO6P57WYS/sa/m0LH6hdW3aMvS
X-Google-Smtp-Source: APiQypKqbvvrHt3rVmPASYetPS/GrupbCiwnGjgHVMktjI4iOKzabZXZJa0yYnYlhTGMXtU/W7DQCQrQWE5LGJZT828=
X-Received: by 2002:a0c:eb09:: with SMTP id j9mr29701104qvp.196.1588100280228;
 Tue, 28 Apr 2020 11:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200428173742.2988395-1-vkabatov@redhat.com>
In-Reply-To: <20200428173742.2988395-1-vkabatov@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 28 Apr 2020 11:57:49 -0700
Message-ID: <CAEf4Bzbp44pnj-yNP61enxh8-ZvFn56fSF4uDHLz0ZcY-H2yAA@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/bpf: Copy runqslower to OUTPUT directory
To:     Veronika Kabatova <vkabatov@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 28, 2020 at 10:38 AM Veronika Kabatova <vkabatov@redhat.com> wrote:
>
> $(OUTPUT)/runqslower makefile target doesn't actually create runqslower
> binary in the $(OUTPUT) directory. As lib.mk expects all
> TEST_GEN_PROGS_EXTENDED (which runqslower is a part of) to be present in
> the OUTPUT directory, this results in an error when running e.g. `make
> install`:
>
> rsync: link_stat "tools/testing/selftests/bpf/runqslower" failed: No
>        such file or directory (2)
>
> Copy the binary into the OUTPUT directory after building it to fix the
> error.
>
> Fixes: 3a0d3092a4ed ("selftests/bpf: Build runqslower from selftests")
> Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
> ---

Looks good, thanks.

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/testing/selftests/bpf/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 7729892e0b04..4e654d41c7af 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -141,7 +141,8 @@ VMLINUX_BTF := $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
>  $(OUTPUT)/runqslower: $(BPFOBJ)
>         $(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower     \
>                     OUTPUT=$(SCRATCH_DIR)/ VMLINUX_BTF=$(VMLINUX_BTF)   \
> -                   BPFOBJ=$(BPFOBJ) BPF_INCLUDE=$(INCLUDE_DIR)
> +                   BPFOBJ=$(BPFOBJ) BPF_INCLUDE=$(INCLUDE_DIR) &&      \
> +                   cp $(SCRATCH_DIR)/runqslower $@
>
>  $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(OUTPUT)/test_stub.o $(BPFOBJ)
>
> --
> 2.25.1
>
