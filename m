Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC5234575B
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 06:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhCWFbo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 01:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhCWFbZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Mar 2021 01:31:25 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637F6C061574
        for <bpf@vger.kernel.org>; Mon, 22 Mar 2021 22:31:25 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id t6so17078889ilp.11
        for <bpf@vger.kernel.org>; Mon, 22 Mar 2021 22:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=NccPQJgmd760oVQnGVA+P4LhyVpXpkZaW4BVeP4+ngc=;
        b=jyngua4TIg+DmnOHjCnm/AfZ/qtMiAqkGe/dkHqsfj623XERqDSNPvYCcCHi646PQ8
         pU65WJCsdK5AAM5x2L0kMaO//UFlVzxYDdFu3CepeW8fRU+wo7bRD4dSGYR4ritE6q3d
         EJ9YqihDwj2CsbtZb+iX95IGIlmhEPVB8yNZ55gh5BpLGGWhdsVXRxPjhX2WlMejFYqx
         Hrief6LG+Kowdji9YYta9HRzzqv/M2ZWZrpCUny0wEQwWu097SSWNXmH8z74WN+Fxyme
         2MFJj1dB3jIwpMc/i3v0QrPBoheZkvbDkLh78Py+foV90zlecinOCepE9vqUvybUFMrT
         bmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=NccPQJgmd760oVQnGVA+P4LhyVpXpkZaW4BVeP4+ngc=;
        b=G6Vnx2ezHlXegOsfBdaGvB0J+i5fKgfGYY3mN3hUuvqI04Ba5OMSkto52I4jhQouhR
         TjhoiPVUhlY2GnoEN1oW5/oevDEDkRyG66SOSBQWz98+jXOr48D/NSkBYFQECVZ4QTQG
         njqT+Zw4o/0oCvGswlUxWZ7jgw9fOzM3Gnd2DFyVlFOpDejjH1H76FDXBfnKI515APeB
         NNkz3TKC45kYloTHxrkupTVbI3fU8BHU3NAAoinPYjwdXtewM8WNT3cdcWhV8BIlBR10
         VgHVzLBDmzS+cFyljmEkAoX24+NiO7CtjVm3DA4xlQ+6mR1VTGtG4n2sxRPig44DIZUy
         OtSw==
X-Gm-Message-State: AOAM532y40TeKfPSPbQVT9QMNoM6wowpT5+pKECewFrClLsQ65VW0cMI
        PL9twqyfCh+5o2yc8w2f+QE=
X-Google-Smtp-Source: ABdhPJzPKaF1O2rC3ih3OGY72RSvRR4VFuF7DD949lArVJcxLqEso+KQxQcM+JhiBksGMoGnR7Erbw==
X-Received: by 2002:a92:d58e:: with SMTP id a14mr3027043iln.61.1616477483889;
        Mon, 22 Mar 2021 22:31:23 -0700 (PDT)
Received: from localhost ([172.242.244.146])
        by smtp.gmail.com with ESMTPSA id 74sm8601720iob.43.2021.03.22.22.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 22:31:23 -0700 (PDT)
Date:   Mon, 22 Mar 2021 22:31:13 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Rafael David Tinoco <rafaeldtinoco@ubuntu.com>, bpf@vger.kernel.org
Cc:     andrii.nakryiko@gmail.com, rafaeldtinoco@ubuntu.com
Message-ID: <60597d21d7eed_45ba42086@john-XPS-13-9370.notmuch>
In-Reply-To: <20210323040952.2118241-1-rafaeldtinoco@ubuntu.com>
References: <20210323040952.2118241-1-rafaeldtinoco@ubuntu.com>
Subject: RE: [PATCH v3 bpf-next] libbpf: add bpf object kern_version attribute
 setter
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Rafael David Tinoco wrote:
> Unfortunately some distros don't have their kernel version defined
> accurately in <linux/version.h> due to different long term support
> reasons.
> 
> It is important to have a way to override the bpf kern_version
> attribute during runtime: some old kernels might still check for
> kern_version attribute during bpf_prog_load().
> 
> Signed-off-by: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
> ---
>  tools/lib/bpf/libbpf.c   | 10 ++++++++++
>  tools/lib/bpf/libbpf.h   |  1 +
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 12 insertions(+)
> 

Hi Andrii and Rafael,

Did you consider making kernel version an attribute of the load
API, bpf_prog_load_xattr()? This feels slightly more natural
to me, to tell the API the kernel you need at load time.

Although, I don't use the skeleton pieces so maybe it would be
awkward for that usage.

Sorry, missed v1,v2 so didn't reply sooner.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 058b643cbcb1..3ac3d8dced7f 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8269,6 +8269,16 @@ int bpf_object__btf_fd(const struct bpf_object *obj)
>  	return obj->btf ? btf__fd(obj->btf) : -1;
>  }
>  
> +int bpf_object__set_kversion(struct bpf_object *obj, __u32 kern_version)
> +{
> +	if (obj->loaded)
> +		return -EINVAL;
> +
> +	obj->kern_version = kern_version;
> +
> +	return 0;
> +}
> +

Having a test to read uname and feed it into libbpf using
above to be sure we don't break this in the future would be
nice.

>  int bpf_object__set_priv(struct bpf_object *obj, void *priv,
>  			 bpf_object_clear_priv_t clear_priv)
>  {
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index a1a424b9b8ff..cf9bc6f1f925 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -143,6 +143,7 @@ LIBBPF_API int bpf_object__unload(struct bpf_object *obj);
>  
>  LIBBPF_API const char *bpf_object__name(const struct bpf_object *obj);
>  LIBBPF_API unsigned int bpf_object__kversion(const struct bpf_object *obj);
> +LIBBPF_API int bpf_object__set_kversion(struct bpf_object *obj, __u32 kern_version);
>  
>  struct btf;
>  LIBBPF_API struct btf *bpf_object__btf(const struct bpf_object *obj);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 279ae861f568..f5990f7208ce 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -359,4 +359,5 @@ LIBBPF_0.4.0 {
>  		bpf_linker__finalize;
>  		bpf_linker__free;
>  		bpf_linker__new;
> +		bpf_object__set_kversion;
>  } LIBBPF_0.3.0;
> -- 
> 2.27.0
> 
