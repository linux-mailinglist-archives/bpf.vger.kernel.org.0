Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35872D1B99
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 22:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgLGVFM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 16:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgLGVFM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 16:05:12 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3D2C061749;
        Mon,  7 Dec 2020 13:04:32 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id k2so16993454oic.13;
        Mon, 07 Dec 2020 13:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=cJ62JFUhP5zgABSp3fn8pdS4RMxFYvfg32dIjTX9vaU=;
        b=ZDpsg3E/+Nq7MJ/v7Uxff8IAu/Hm7yxgeE0QUaPWzpJamhxR8d3UiJIUYMzQDlnlY3
         6x9ncuBw8n1j7tD/FpB18qfl2biiQ7Yzwi2FRl/2bp+s4LinLo8AZux7MBYXpPN6HoH+
         VgFv92tfCkjIlJXei+R50b5AM/SnEBpMOgZ1JtAITWZCLQzUrePD+UVRkUk5HNShzy2n
         SU5w/ZqzPyjn6tiEsZz0UpN8mSek9Gt9R+CotzhikWs1MAwkSEaehgusu4tQ2zkNu15k
         uhOGReyOdW8s/QXUQqOfrRxrfIIhfVLUpvNkGanrjukdtRMH4foAFcxK38uPhopRN+Fh
         S2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=cJ62JFUhP5zgABSp3fn8pdS4RMxFYvfg32dIjTX9vaU=;
        b=fdn4yusY1HzyRsVdSFPcpnm5oN9riFjLuV5Soi1uV2JNPyZk8XM0QVEHRfI/acTPCL
         XYOh72UIXf0s4bfpRVmXwJmkp5V4P7S7PfaDROG1u8dszujn1oeHdngbyMuEgTVK31fF
         fQUlFhJvo7kOP6etJK37DiprqJzaMdimbIWc95ERctbxbJRjm+NgxSGwyoDK7BDo9Zy/
         yx60IyLDAJ89HgXqZkAQnAXO95hAGP3eOwRNzWRskFARyVGb0A+yRzG6zGVKkY8heVlx
         97l/g2M5f6iCjCdKEEaNoqsthnvGxxW6ZXHKkq0AyYvcYNIpgZP6IFyGxAPoEOmgeCpX
         wllw==
X-Gm-Message-State: AOAM532eIERWsV7vSdGfKS6dA+NS/uAwkCrlTWWuyXu7G/QFuX5UICrp
        TsE8BCiJMi7HTqJfNUysw1w=
X-Google-Smtp-Source: ABdhPJzWtCQg5yyMdVU/c4RdlM2OJkkRnn24xqwAma92VFEXSxwnfQWPvAxl53brmSiaf0wzIlXcWg==
X-Received: by 2002:aca:5e03:: with SMTP id s3mr493601oib.125.1607375071747;
        Mon, 07 Dec 2020 13:04:31 -0800 (PST)
Received: from localhost ([184.21.204.5])
        by smtp.gmail.com with ESMTPSA id o21sm1579819otj.1.2020.12.07.13.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 13:04:31 -0800 (PST)
Date:   Mon, 07 Dec 2020 13:04:23 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Brendan Jackman <jackmanb@google.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Brendan Jackman <jackmanb@google.com>
Message-ID: <5fce98d7d860e_5a9620833@john-XPS-13-9370.notmuch>
In-Reply-To: <20201207160734.2345502-2-jackmanb@google.com>
References: <20201207160734.2345502-1-jackmanb@google.com>
 <20201207160734.2345502-2-jackmanb@google.com>
Subject: RE: [PATCH bpf-next v4 01/11] bpf: x86: Factor out emission of ModR/M
 for *(reg + off)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Brendan Jackman wrote:
> The case for JITing atomics is about to get more complicated. Let's
> factor out some common code to make the review and result more
> readable.
> 
> NB the atomics code doesn't yet use the new helper - a subsequent
> patch will add its use as a side-effect of other changes.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---

Small nit on style preference below.

Acked-by: John Fastabend <john.fastabend@gmail.com>

[...]

>  
> @@ -1240,11 +1250,7 @@ st:			if (is_imm8(insn->off))
>  			goto xadd;
>  		case BPF_STX | BPF_XADD | BPF_DW:
>  			EMIT3(0xF0, add_2mod(0x48, dst_reg, src_reg), 0x01);
> -xadd:			if (is_imm8(insn->off))
> -				EMIT2(add_2reg(0x40, dst_reg, src_reg), insn->off);
> -			else
> -				EMIT1_off32(add_2reg(0x80, dst_reg, src_reg),
> -					    insn->off);
> +xadd:			emit_modrm_dstoff(&prog, dst_reg, src_reg, insn->off);

I at least prefer the xadd on its own line above the emit_*(). That seems
more consistent with the rest of the code in this file. The only other
example like this is st:.
