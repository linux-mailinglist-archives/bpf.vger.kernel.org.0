Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBF867C25A
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 02:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjAZB2W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 20:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbjAZB2T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 20:28:19 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EB51284F
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 17:28:15 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id 5so635406plo.3
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 17:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h8fwo4093KUxjPiK6FyGFW3cQuuP+ScCRAabMzzpj60=;
        b=fl8XoTsAo6t8gJCbXlVP3K51TS5i9ZqhM8y1zA9neyJNussF5AdG9Q3KDpJLdw5aK1
         qkiKu7LWNt0QCJgiBXD6i3HyJCnKq80U4Hx4w0+XvUuaaEX3xnu66kBZB6QQMRUiIW9r
         li8vasmItwOjbdfYrOX1A1iALL4Z6PaE7gYdoqfni1S7t/L3QSzU4hKdS1okPenCUcM/
         khqBwdZMaA+0d7lD5tTODvqaCyHbiOmrDkWC+TT5ACrqJ5TncYsSDyz0ZcaMGPfSzqhu
         5v4d4yMv1HKLKDJObc1OaKitvEVfW90cPmytUTmwCgCjJHjSHoO1/hId6XijIB1wd7SJ
         9q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8fwo4093KUxjPiK6FyGFW3cQuuP+ScCRAabMzzpj60=;
        b=w0YyL7V1rfnqGxvXajVZdVtI3GKizCU6UwfJHV3OTdC9TZwldraie4MyzYXAc9jGEi
         hw5CPat8Gxd2GSwBUfAc4ZlLyxCJAIbe5h91Rj/Du94ORZ/NIL2CyG5JqKwn5zCSXQ47
         S/ZSTKlAe2SqPZSbrThrUmy1Qg/R5HUCOiRCP7fXJJFvjbmD/QXsDXiZWevYNi/sXnz1
         M/nBX0CFUuzEOTbHOF/lzCly5Xzdy6Ug07YOzVcf+WanSnkv7MhfGQqBVOhgtapQzKM0
         xJia6vZsx0jO53M+YkOH3EeW9NpNiqLk/KM1jhvzMx4yWUOmXcRwjLFPcNQPvhtgdksW
         qa7A==
X-Gm-Message-State: AO0yUKWD3geyeoGAWp8nds29MsWA3k+hSqpc4IQWGjlX0hlQ+gfSzreb
        GbBt0w/rpaNkfudoNeA9Pq94HKe0enQ=
X-Google-Smtp-Source: AK7set9ohRpVHM15ZZXA+Zoma2A4ZRoqBO/JE3QDD2ve13NL/G/irLIaC887xnUBQUNUa9zjnsnrWQ==
X-Received: by 2002:a17:902:c78a:b0:196:35cf:3afe with SMTP id w10-20020a170902c78a00b0019635cf3afemr2072802pla.38.1674696495127;
        Wed, 25 Jan 2023 17:28:15 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:500::6:b1d5])
        by smtp.gmail.com with ESMTPSA id v7-20020a1709029a0700b00192d3e7eb8fsm2823plp.252.2023.01.25.17.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 17:28:14 -0800 (PST)
Date:   Wed, 25 Jan 2023 17:28:12 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH bpf-next 24/24] s390/bpf: Implement
 bpf_jit_supports_kfunc_call()
Message-ID: <20230126012812.vqg3oktknpnvvssf@macbook-pro-6.dhcp.thefacebook.com>
References: <20230125213817.1424447-1-iii@linux.ibm.com>
 <20230125213817.1424447-25-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125213817.1424447-25-iii@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 25, 2023 at 10:38:17PM +0100, Ilya Leoshkevich wrote:
> +
> +		/* Sign-extend the kfunc arguments. */
> +		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
> +			m = bpf_jit_find_kfunc_model(fp, insn);
> +			if (!m)
> +				return -1;
> +
> +			for (j = 0; j < m->nr_args; j++) {
> +				if (sign_extend(jit, BPF_REG_1 + j,
> +						m->arg_size[j],
> +						m->arg_flags[j]))
> +					return -1;
> +			}
> +		}

Is this because s390 doesn't have subregisters?
Could you give an example where it's necessary?
I'm guessing a bpf prog compiled with alu32 and operates on signed int
that is passed into a kfunc that expects 'int' in 64-bit reg?

>  
> +bool bpf_jit_supports_kfunc_call(void)
> +{
> +	return true;
> +}

Timely :) Thanks for working it.
