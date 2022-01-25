Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D500449B913
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 17:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbiAYQo5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 11:44:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20551 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1585109AbiAYQl2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 25 Jan 2022 11:41:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643128887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GbY3XP61M3uD9sP2FFUZOwoizO9Z7SgKKtfr4x3BErc=;
        b=VejCggiVheMdoxcliVm59WLZ8cI4JiPonkrW10Ip8MF5LLdsC1uVMNMT9/3mlA7a15Oorm
        97B+WAlhu87Rn3QAzv0GLfNMIlQ1QhpmH9wUBHCkkQLolcZ6ynP5gbBxH1t/Ma0kIGDp73
        Vd1rRYwjNF/55ran80KXnjOBQpRNn0Q=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-dEOjJg5gNKSsVoNE82C7fQ-1; Tue, 25 Jan 2022 11:41:26 -0500
X-MC-Unique: dEOjJg5gNKSsVoNE82C7fQ-1
Received: by mail-ej1-f70.google.com with SMTP id h22-20020a1709060f5600b006b11a2d3dcfso3655153ejj.4
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 08:41:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GbY3XP61M3uD9sP2FFUZOwoizO9Z7SgKKtfr4x3BErc=;
        b=s3gHDSYb3N8A6pU2dLsrhEi+us8Nu9EEWdB9AuEtZe7vhxkEzS7HD/+talUsdV6CiU
         iek2EYJzbJoxFpZuqMaXAgvnqP10QbiBTsGrPoKE7i783vwN2D6U1ypgVxv/BOqDcgeO
         7yfg+sPg+3mXTcN9NG833LuiA6H45SxiYPLMlI+EGC2JuKFPeuUHa+AcaaOoviUHU9tA
         N6Y+JhcAkGnPnjNkV4dhXa4y1TIcQWdTyTUShlGGh/nmBAI+/CCE+phBEvMs9QETq3yE
         7mVm7Jp+u6PwxdPX6gFygU8nWL4S/pF69KCIrEcWJwr0IS+8XYVoAI47Nppq//SFvIKh
         gKwQ==
X-Gm-Message-State: AOAM530GsWMNgj0Lz8SadWRbv3YrvN8W+J1K2lDeZZN0kss+BQpivx9Z
        KJY50rP6q2yY9OnY724BUbQpLx4pziwD0fx9BxJbvMrcYEALUlj8JVFGhGCujSZstxrlaD3IjLC
        iH8a/SV1KH++s
X-Received: by 2002:a17:907:3f29:: with SMTP id hq41mr6272874ejc.358.1643128884403;
        Tue, 25 Jan 2022 08:41:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwg37J+bP3Vw6kcPaqHnw/mAqqdxblwP1MOYVrCrqDDNprj6rBqlub90ZLbiCa3i8cWgEnxKg==
X-Received: by 2002:a17:907:3f29:: with SMTP id hq41mr6272861ejc.358.1643128884190;
        Tue, 25 Jan 2022 08:41:24 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id a14sm8449020edx.96.2022.01.25.08.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 08:41:23 -0800 (PST)
Date:   Tue, 25 Jan 2022 17:41:21 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 2/9] fprobe: Add ftrace based probe APIs
Message-ID: <YfAoMW6i4gqw2Na0@krava>
References: <164311269435.1933078.6963769885544050138.stgit@devnote2>
 <164311271777.1933078.9066058105807126444.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164311271777.1933078.9066058105807126444.stgit@devnote2>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 25, 2022 at 09:11:57PM +0900, Masami Hiramatsu wrote:

SNIP

> +
> +/* Convert ftrace location address from symbols */
> +static int convert_func_addresses(struct fprobe *fp)
> +{
> +	unsigned long addr, size;
> +	unsigned int i;
> +
> +	/* Convert symbols to symbol address */
> +	if (fp->syms) {
> +		fp->addrs = kcalloc(fp->nentry, sizeof(*fp->addrs), GFP_KERNEL);
> +		if (!fp->addrs)
> +			return -ENOMEM;
> +
> +		for (i = 0; i < fp->nentry; i++) {
> +			fp->addrs[i] = kallsyms_lookup_name(fp->syms[i]);
> +			if (!fp->addrs[i])	/* Maybe wrong symbol */
> +				goto error;
> +		}
> +	}
> +
> +	/* Convert symbol address to ftrace location. */
> +	for (i = 0; i < fp->nentry; i++) {
> +		if (!kallsyms_lookup_size_offset(fp->addrs[i], &size, NULL))
> +			size = MCOUNT_INSN_SIZE;
> +		addr = ftrace_location_range(fp->addrs[i], fp->addrs[i] + size);

you need to substract 1 from 'end' in here, as explained in
__within_notrace_func comment:

        /*
         * Since ftrace_location_range() does inclusive range check, we need
         * to subtract 1 byte from the end address.
         */

like in the patch below

also this convert is for archs where address from kallsyms does not match
the real attach addresss, like for arm you mentioned earlier, right?

could we have that arch specific, so we don't have extra heavy search
loop for archs that do not need it?

thanks,
jirka


---
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 4d089dda89c2..7970418820e7 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -91,7 +91,7 @@ static int convert_func_addresses(struct fprobe *fp)
 	for (i = 0; i < fp->nentry; i++) {
 		if (!kallsyms_lookup_size_offset(fp->addrs[i], &size, NULL))
 			size = MCOUNT_INSN_SIZE;
-		addr = ftrace_location_range(fp->addrs[i], fp->addrs[i] + size);
+		addr = ftrace_location_range(fp->addrs[i], fp->addrs[i] + size - 1);
 		if (!addr) /* No dynamic ftrace there. */
 			goto error;
 		fp->addrs[i] = addr;

