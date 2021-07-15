Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB883C9C79
	for <lists+bpf@lfdr.de>; Thu, 15 Jul 2021 12:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241231AbhGOKPd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 06:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbhGOKPd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Jul 2021 06:15:33 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3BDC06175F
        for <bpf@vger.kernel.org>; Thu, 15 Jul 2021 03:12:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l6so3397090wmq.0
        for <bpf@vger.kernel.org>; Thu, 15 Jul 2021 03:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CHboCMPa0noGTp43ghSeaxA/2+JfGKkbAyG3uY4v+h8=;
        b=efrKELc5FmrrjhQ6qQ6/NWH3CLOu1vf0l7wC27KHlywSzimWurCcTsaq9DGuYOZNTq
         ZmVrsle3ov5DbWqy5yIJPYonYZLvq3xd2baVy4PYXQMkc5ZF5TcCp3b7j5B7KP40D6HP
         7DEPT+5v8LJEB4pBkJCLRhQZFYiDcLkl/UlShD581B21/W+dubCECzlv0Wuu51RSeziz
         d5XrmXrARU7YXTJznuqQqChXNVUgotkPw4LsLjO0rWeLIhsGod/kTuq6FYQx21NMqy3Q
         +QcG9Le8P6eVZPjVi76ls38o1bRribvv91TtyP1WtpsPOAS/9d3WetsufNeo9lBIYeKA
         BoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CHboCMPa0noGTp43ghSeaxA/2+JfGKkbAyG3uY4v+h8=;
        b=TkBEi7xnY8DE+66AMBDpk5rbfjYFjmqlNoYiF4pkv1ESdYWi2I6oy5h2u1HrxDxmAZ
         IkMSIEUXRdiNoMerWmDRuQ1iYfuUOXVMi97MxZ2R0SvMhBO0j1cFMde7fMRpo2KLl9YV
         KJHoynuUO8wBYFr03FgqI8zEAO4q2tIcSrCg6HERq4Hgnq1rz6LwyAnl36XfG4Fwf5ki
         sCAKQpYy/7WIIAeDBCAt5Ps+KYfKD/5nuEZlxSzXZgotIivU7Jfw3rA+a/OBUOyW53aJ
         qcLcAlL05albjlNXw+mIxgwpK1bEYeahG0WHc0wmAh8yJfElD6ungIdgplGjCzIJJbrS
         wAWQ==
X-Gm-Message-State: AOAM533eUpC12Ka0IEV5ulhYkzzetJpKSiPF1UGFYQPziCtWh+H5Xo/T
        3OYeSQOdu0/zHa8fe6IAKHIZ9Q==
X-Google-Smtp-Source: ABdhPJyVIryR/acM4TV7SmvDZB14OvVpl6D1BJnU7/3mWK9N77CkI5agC8tjQ52EvsXTRBPV0xd2Xg==
X-Received: by 2002:a7b:cb13:: with SMTP id u19mr3634232wmj.122.1626343958636;
        Thu, 15 Jul 2021 03:12:38 -0700 (PDT)
Received: from [192.168.1.8] ([149.86.88.136])
        by smtp.gmail.com with ESMTPSA id s1sm7937205wmj.8.2021.07.15.03.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 03:12:38 -0700 (PDT)
Subject: Re: [PATCH bpf-next 1/2] tools/lib/bpf: bpf_program__insns allow to
 retrieve insns in libbpf
To:     Lorenzo Fontana <fontanalorenz@gmail.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net
References: <aa97c776-9a82-9acc-fb13-dd082fdcaa61@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <54e477a7-459a-40be-b34e-3e2e0a75c75a@isovalent.com>
Date:   Thu, 15 Jul 2021 11:12:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <aa97c776-9a82-9acc-fb13-dd082fdcaa61@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2021-07-13 20:33 UTC+0200 ~ Lorenzo Fontana <fontanalorenz@gmail.com>
> This allows consumers of libbpf to iterate trough the insns
> of a program without loading it first directly after the ELF parsing.
> 
> Being able to do that is useful to create tooling that can show
> the structure of a BPF program using libbpf without having to
> parse the ELF separately.
> 
> Usage:
>   struct bpf_insn *insn;
>   insn = bpf_program__insns(prog);
> 
> Signed-off-by: Lorenzo Fontana <fontanalorenz@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 5 +++++
>  tools/lib/bpf/libbpf.h | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 1e04ce724240..67d51531f6b6 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8866,6 +8866,11 @@ void *bpf_program__priv(const struct bpf_program *prog)
>  	return prog ? prog->priv : libbpf_err_ptr(-EINVAL);
>  }
>  
> +struct bpf_insn *bpf_program__insns(const struct bpf_program *prog)
> +{
> +	return prog ? prog->insns : libbpf_err_ptr(-EINVAL);
> +}
> +
>  void bpf_program__set_ifindex(struct bpf_program *prog, __u32 ifindex)
>  {
>  	prog->prog_ifindex = ifindex;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 6e61342ba56c..e4a1c98ae6d9 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -195,6 +195,7 @@ typedef void (*bpf_program_clear_priv_t)(struct bpf_program *, void *);
>  LIBBPF_API int bpf_program__set_priv(struct bpf_program *prog, void *priv,
>  				     bpf_program_clear_priv_t clear_priv);
>  
> +LIBBPF_API struct bpf_insn *bpf_program__insns(const struct bpf_program *prog);
>  LIBBPF_API void *bpf_program__priv(const struct bpf_program *prog);
>  LIBBPF_API void bpf_program__set_ifindex(struct bpf_program *prog,
>  					 __u32 ifindex);
> 

If you make it part of the API, the new function should also have an
entry in tools/lib/bpf/libbpf.map.

Quentin
