Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71FC69FE28
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 23:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjBVWLP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 17:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjBVWLE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 17:11:04 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E964740C
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 14:11:02 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id cy6so30864066edb.5
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 14:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vruF+LldcRPL5jnemAxE0tn+dUv4CU1Dwmh5jSiKeLg=;
        b=hRk7MOsN2nh5agAVjZixHCGJfaHFMyM9r2ExvW/7PHeBO1sHW8ict3Yc+LxYr2E2rt
         bD4Y8jQXawZ384xscyYQsZ+FRrG8+gpnVrjzq4YWkcFNHPtM6/lQ8+kVhmbIRU14i6C2
         kyfPEnmfGCPFPFWQ1nSzp/w4tKSXeUaxnnoh7RUPhpwjbHuahWvCRFpA9jvUS7qkVNcl
         8wVIS2eSrkmp2tfvbmPDuQwyvyLXFmUw4/BfAN33wOEu/pos1XnKn1ANt2r6x+Vnmsij
         aBwrjGoGIjG6l1/eLMeZrtEO5VNYmt8E44mblETunBOzP08uTEQp1XDflrVoJuRQ2EX9
         zIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vruF+LldcRPL5jnemAxE0tn+dUv4CU1Dwmh5jSiKeLg=;
        b=enJj+M4T8dM612sbRKIXZMbcw6kn7giVWlOGDgk6s3fOXwo2is8rhI8rNtwPXhrdMy
         peEaFLh2OnqLAYDkq/uixWdoIzB9OJXqbgFBISt/IHpWxBTkRV+knql4zUzRcIzQhqd5
         3MaM7cBR9Z3rhQmBUZE+ndVPEDMZ7RPcin6bUsS2M932Fg5UKwFZsLtUzj2YBaLrGHRo
         7Jj8LDKRgjczxR3M/SdqWoHpD5BNjGl+I91HVv6QuFl3R7Oep914wah33aPzJCtuhzvb
         IfELV9NvLekZt1TFwrMXE+3c/KjuDQsXBvSX6uSMOOlkhw/6jJoNfgRZAS3xur9ZTxDQ
         P9uA==
X-Gm-Message-State: AO0yUKW6fYQk/JTNIXLeT9F8e6+ud6ppT6Ke4EUTm3Pobu4iDmk3FIho
        GKkjGJpmuAj4i9X5OGK1tGLP8iUwDwYVx37VNyVNLSiNwME=
X-Google-Smtp-Source: AK7set8ICi34Jy9rAN5s1xbN/v/yNjViOmjO7/V97V3VL7Tx4j5G02uah0X00AA3M8k4VZsDjow/DlyTc6Qc5Hk3TFE=
X-Received: by 2002:a50:d544:0:b0:4ad:6e3e:7da6 with SMTP id
 f4-20020a50d544000000b004ad6e3e7da6mr4543403edj.6.1677103861116; Wed, 22 Feb
 2023 14:11:01 -0800 (PST)
MIME-Version: 1.0
References: <20230220223742.1347-1-dthaler1968@googlemail.com>
In-Reply-To: <20230220223742.1347-1-dthaler1968@googlemail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 22 Feb 2023 14:10:49 -0800
Message-ID: <CAADnVQ++hR7Cj3OXGLWpV_=4MnFndq5qS8r5b-YYPC_OB=gjQg@mail.gmail.com>
Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Add explanation of endianness
To:     Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc:     bpf <bpf@vger.kernel.org>, bpf@ietf.org,
        Dave Thaler <dthaler@microsoft.com>,
        David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 20, 2023 at 2:37 PM Dave Thaler
<dthaler1968=40googlemail.com@dmarc.ietf.org> wrote:
>
> From: Dave Thaler <dthaler@microsoft.com>
>
> Document the discussion from the email thread on the IETF bpf list,
> where it was explained that the raw format varies by endianness
> of the processor.
>
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
>
> Acked-by: David Vernet <void@manifault.com>
> ---
>
> V1 -> V2: rebased on top of latest master
> ---
>  Documentation/bpf/instruction-set.rst | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> index af515de5fc3..1d473f060fa 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -38,8 +38,9 @@ eBPF has two instruction encodings:
>  * the wide instruction encoding, which appends a second 64-bit immediate (i.e.,
>    constant) value after the basic instruction for a total of 128 bits.
>
> -The basic instruction encoding is as follows, where MSB and LSB mean the most significant
> -bits and least significant bits, respectively:
> +The basic instruction encoding looks as follows for a little-endian processor,
> +where MSB and LSB mean the most significant bits and least significant bits,
> +respectively:
>
>  =============  =======  =======  =======  ============
>  32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
> @@ -63,6 +64,17 @@ imm            offset   src_reg  dst_reg  opcode
>  **opcode**
>    operation to perform
>
> +and as follows for a big-endian processor:
> +
> +=============  =======  ====================  ===============  ============
> +32 bits (MSB)  16 bits  4 bits                4 bits           8 bits (LSB)
> +=============  =======  ====================  ===============  ============
> +immediate      offset   destination register  source register  opcode
> +=============  =======  ====================  ===============  ============

I've changed it to:
imm            offset   dst_reg  src_reg  opcode

to match the little endian table,
but now one of the tables feels wrong.
The encoding is always done by applying C standard to the struct:
struct bpf_insn {
        __u8    code;           /* opcode */
        __u8    dst_reg:4;      /* dest register */
        __u8    src_reg:4;      /* source register */
        __s16   off;            /* signed offset */
        __s32   imm;            /* signed immediate constant */
};
I'm not sure how to express this clearly in the table.
