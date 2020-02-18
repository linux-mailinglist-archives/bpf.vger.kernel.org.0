Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B812B162AB4
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2020 17:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgBRQeO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Feb 2020 11:34:14 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51143 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgBRQeO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Feb 2020 11:34:14 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so3448219wmb.0
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2020 08:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=cw7YJYJa4z3Aqqqg8Aza546uVReGq65A025/7Z3/ppA=;
        b=yxsHoOEhel5s5bqVemPEi+cH8w1si/yClOoZDyIbsrUlvo/mJaEFUuxlFdFU4GjnuX
         YIKZL02vNDazWPDC4rxjxwrB0kr3LxSOeiYJnFkdyw7ffus701eZYV/NmLmgGAf4BupV
         sxC+UR3elp9JIbDXCy2evcFlh6CKaf+brMrZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=cw7YJYJa4z3Aqqqg8Aza546uVReGq65A025/7Z3/ppA=;
        b=kcNi1zKE0fMxOP++3wNLs/TtHjF3UbxviP69E3rn3eWZNAzMi1OXBVGaUFDsT82gu+
         b0ChmXLK3qVRUfB9uQk4BPEvp3kXfTjSJcIJKHBRHw3rZPilTFzO2sE1+RXOUmq9Joc9
         ht6e62DyX0tRtbRoKtcEEmymxyN8iS5dQFKWoyBe+oaMgLTkVCydi8Zr1sMHJP2P8YDm
         5iVSZTUtFKgX3Ahp2CX8K1L5vYbYw1TWby5SkItt1ZkdJAsX5Miae08RQ+VfFJ+/dmWM
         Zo80tOZwL8dBgu6F/OBoxicq9mAGEHCMp9HrSFkrT/j6zwCW37BmeJlrU1NNIJpzQhu1
         RkwQ==
X-Gm-Message-State: APjAAAWdS7tufwhlaGLmLRq9rr1d2nATl2CQNO9UiHD6o5W12fjjNOCG
        eXCFEVX/yHPDSYIEAI76P8bB+Q==
X-Google-Smtp-Source: APXvYqyGDEPyzWI2eUH+7RsisEeulez1sba3cSK16cfs65nZBmZScuJdZNUcBQyzRJGqOClyJyIHQQ==
X-Received: by 2002:a05:600c:294:: with SMTP id 20mr4115930wmk.135.1582043650715;
        Tue, 18 Feb 2020 08:34:10 -0800 (PST)
Received: from cloudflare.com ([88.157.168.82])
        by smtp.gmail.com with ESMTPSA id p26sm3950700wmc.24.2020.02.18.08.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 08:34:10 -0800 (PST)
References: <158194337246.104074.6407151818088717541.stgit@xdp-tutorial> <158194341424.104074.4927911845622583345.stgit@xdp-tutorial>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Eelco Chaudron <echaudro@redhat.com>
Cc:     bpf@vger.kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com, toke@redhat.com
Subject: Re: [PATCH bpf-next v4 2/3] libbpf: Add support for dynamic program attach target
In-reply-to: <158194341424.104074.4927911845622583345.stgit@xdp-tutorial>
Date:   Tue, 18 Feb 2020 16:34:08 +0000
Message-ID: <877e0jam7z.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hey Eelco,

On Mon, Feb 17, 2020 at 12:43 PM GMT, Eelco Chaudron wrote:
> Currently when you want to attach a trace program to a bpf program
> the section name needs to match the tracepoint/function semantics.
>
> However the addition of the bpf_program__set_attach_target() API
> allows you to specify the tracepoint/function dynamically.
>
> The call flow would look something like this:
>
>   xdp_fd =3D bpf_prog_get_fd_by_id(id);
>   trace_obj =3D bpf_object__open_file("func.o", NULL);
>   prog =3D bpf_object__find_program_by_title(trace_obj,
>                                            "fentry/myfunc");
>   bpf_program__set_expected_attach_type(prog, BPF_TRACE_FENTRY);
>   bpf_program__set_attach_target(prog, xdp_fd,
>                                  "xdpfilt_blk_all");
>   bpf_object__load(trace_obj)
>
> Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
> ---
>  tools/lib/bpf/libbpf.c   |   34 ++++++++++++++++++++++++++++++----
>  tools/lib/bpf/libbpf.h   |    4 ++++
>  tools/lib/bpf/libbpf.map |    2 ++
>  3 files changed, 36 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 514b1a524abb..0c25d78fb5d8 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[...]

> @@ -8132,6 +8133,31 @@ void bpf_program__bpil_offs_to_addr(struct bpf_pro=
g_info_linear *info_linear)
>  	}
>  }
>
> +int bpf_program__set_attach_target(struct bpf_program *prog,
> +				   int attach_prog_fd,
> +				   const char *attach_func_name)
> +{
> +	int btf_id;
> +
> +	if (!prog || attach_prog_fd < 0 || !attach_func_name)
> +		return -EINVAL;
> +
> +	if (attach_prog_fd)
> +		btf_id =3D libbpf_find_prog_btf_id(attach_func_name,
> +						 attach_prog_fd);
> +	else
> +		btf_id =3D __find_vmlinux_btf_id(prog->obj->btf_vmlinux,
> +					       attach_func_name,
> +					       prog->expected_attach_type);
> +
> +	if (btf_id <=3D 0)
> +		return btf_id;

Looks like we can get 0 as return value on both error and success
(below)?  Is that intentional?

> +
> +	prog->attach_btf_id =3D btf_id;
> +	prog->attach_prog_fd =3D attach_prog_fd;
> +	return 0;
> +}
> +
>  int parse_cpu_mask_str(const char *s, bool **mask, int *mask_sz)
>  {
>  	int err =3D 0, n, len, start, end =3D -1;

[...]
