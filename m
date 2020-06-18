Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5291FFF0A
	for <lists+bpf@lfdr.de>; Fri, 19 Jun 2020 01:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgFRX51 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Jun 2020 19:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbgFRX5W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Jun 2020 19:57:22 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5BFC06174E
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2020 16:57:21 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d10so1275819pls.5
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2020 16:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=8TFE1Oq0k63dc9cJ/FNi5WYf4NKPVBqbuse5CwtRYvI=;
        b=SphocFWjC6fVWpT+8IaM6IgwcsZ4iPpkQ1vo5HbEWjaURWU0NLawArReoNKQur59YY
         URaFI4c8rTn65wd3CM2JnqD0xKNgEn7Snz9D7nQlAiZRlaijdLaxXIimiJxfpzGO+6Vx
         6/ZCd1TC1vFvpOdiECuqwmbjaNz6mx/SHho0EAFckjs0Z3Z9u1hT7L2LjHxrIbgmi0V8
         fw5/6PA7s2GkZho6Q+3lyam8ARRCP2drEc7XVX1dfQ2e9Kv+QRKmBTE1ONd/Z72naGcC
         EEKNpGkXnqw8sfTqBuPTj5IZVOlScE3WCy7UtRPoMi8ZXkij9R9lJUvH/WhCrxQR4L7z
         CK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=8TFE1Oq0k63dc9cJ/FNi5WYf4NKPVBqbuse5CwtRYvI=;
        b=K0ynQQdsXEQWKxJD5ZsIYOlNm2Yr0sw30lEKhGCP9Jcp+CnMQTfJOZRSgSrGGUpRe9
         q0qGDfLCQQ7T1nWrJkqsFJXGnwYmLoBRLYPmnd7gWZP5oQqglqZs/JpePIh480nlAs1O
         ZLLVWo2ISHSOwgZSfhjzXxvCe60szNyHgyM+r+upQ7pqHvjcyAPvVMF3/McQi/DwvkAD
         lgAgQ0Q7nFByNn4pfKyZQjfE3QbgpmnfhDCn/wOTZH7j6HAj4y8oe/Kn2tqzHT+d7hKl
         KC5q2aT/lK5SnD4fH5UX/Sm26v4pFvwozGza2tJ1evMCtOrzaTsuGfzbjJ4vgxb5Wf2B
         kAzg==
X-Gm-Message-State: AOAM533jICC3oltrNonxqdQQU8rtezYFHbPyIqoTVhMk9MyPHbkKN2T+
        pHVda45C4v0bh48qiKdRg7c=
X-Google-Smtp-Source: ABdhPJyLjF9msJ6q4f3w8+u7tJiBmkEClkIwsNbZhKT80mJYVx/l9ZnW44xRGap85PPY+Xm6rAF+EA==
X-Received: by 2002:a17:90a:b903:: with SMTP id p3mr865199pjr.4.1592524641114;
        Thu, 18 Jun 2020 16:57:21 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id q145sm3882425pfq.128.2020.06.18.16.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 16:57:20 -0700 (PDT)
Date:   Thu, 18 Jun 2020 16:57:13 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Message-ID: <5eebff591d2a7_27ce2adb0816a5b864@john-XPS-13-9370.notmuch>
In-Reply-To: <20200618234631.3321118-1-yhs@fb.com>
References: <20200618234631.3321026-1-yhs@fb.com>
 <20200618234631.3321118-1-yhs@fb.com>
Subject: RE: [PATCH bpf-next 1/2] bpf: avoid verifier failure for 32bit
 pointer arithmetic
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song wrote:
> When do experiments with llvm (disabling instcombine and
> simplifyCFG), I hit the following error with test_seg6_loop.o.
> 
>   ; R1=pkt(id=0,off=0,r=48,imm=0), R7=pkt(id=0,off=40,r=48,imm=0)
>   w2 = w7
>   ; R2_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
>   w2 -= w1
>   R2 32-bit pointer arithmetic prohibited
> 
> The corresponding source code is:
>   uint32_t srh_off
>   // srh and skb->data are all packet pointers
>   srh_off = (char *)srh - (char *)(long)skb->data;
> 
> The verifier does not support 32-bit pointer/scalar arithmetic.
> 
> Without my llvm change, the code looks like
> 
>   ; R3=pkt(id=0,off=40,r=48,imm=0), R8=pkt(id=0,off=0,r=48,imm=0)
>   w3 -= w8
>   ; R3_w=inv(id=0)
> 
> This is explicitly allowed in verifier if both registers are
> pointers and the opcode is BPF_SUB.
> 
> To fix this problem, I changed the verifier to allow
> 32-bit pointer/scaler BPF_SUB operations.
> 
> At the source level, the issue could be workarounded with
> inline asm or changing "uint32_t srh_off" to "uint64_t srh_off".
> But I feel that verifier change might be the right thing to do.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Agreed we have same logic in 64-bit case so LGTM.

Acked-by: John Fastabend <john.fastabend@gmail.com>
