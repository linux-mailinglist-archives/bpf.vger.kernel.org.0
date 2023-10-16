Return-Path: <bpf+bounces-12287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 546907CA872
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 14:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD9128170B
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 12:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E637266BC;
	Mon, 16 Oct 2023 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="nCeqBJmd"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44E023751
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 12:47:50 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C49EB4;
	Mon, 16 Oct 2023 05:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=vTBYR5W87uJnQtpbq0bsqTJfD3ou9LZ0vu7LpthX5js=; b=nCeqBJmdNRsAlHhxOhJN1FlmeG
	GNXas+G0Nuj/ojpGAeebDBhXxSfWjS4qP6/X33SxNIprf6UQ9mOOiAfWkb049nYo68nkrxBB8A/zB
	bFr4tJ6qgwidktWnl5RFhXpYrjrjwjINHNR+M9ArDbYYXtDllsiNbrxpZ/ii27TiXV0csfha1tkdE
	Iqy0vuxBey4EdyjK2QXfiiuN+g45V9hgJjX/NgbB07tP3pZf9fKRsKursKaLIwvivwsmUxaI7CCo2
	QjDoqCx871QiCrNCh72GSptV2Kl0rrbdqTckNmOfHf/o1BLRASZ0yJPXYd/fDlraO/eIlQDadFDrT
	6CXkEVLA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qsN0b-000ErM-Si; Mon, 16 Oct 2023 14:47:45 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qsN0b-000MUc-KB; Mon, 16 Oct 2023 14:47:45 +0200
Subject: Re: [PATCH] arch: powerpc: net: bpf_jit_comp32.c: Fixed 'instead'
 typo
To: Muhammad Muzammil <m.muzzammilashraf@gmail.com>, martin.lau@linux.dev,
 yonghong.song@linux.dev, john.fastabend@gmail.com
Cc: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20231013053118.11221-1-m.muzzammilashraf@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <cc25e4b1-9079-1c45-b6d4-7f7f4701df0a@iogearbox.net>
Date: Mon, 16 Oct 2023 14:47:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231013053118.11221-1-m.muzzammilashraf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27063/Mon Oct 16 10:02:17 2023)
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/13/23 7:31 AM, Muhammad Muzammil wrote:
> Fixed 'instead' typo
> 
> Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>

Michael, I presume you'll pick it up?

Thanks,
Daniel

> ---
>   arch/powerpc/net/bpf_jit_comp32.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
> index 7f91ea064c08..bc7f92ec7f2d 100644
> --- a/arch/powerpc/net/bpf_jit_comp32.c
> +++ b/arch/powerpc/net/bpf_jit_comp32.c
> @@ -940,7 +940,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>   				 * !fp->aux->verifier_zext. Emit NOP otherwise.
>   				 *
>   				 * Note that "li reg_h,0" is emitted for BPF_B/H/W case,
> -				 * if necessary. So, jump there insted of emitting an
> +				 * if necessary. So, jump there instead of emitting an
>   				 * additional "li reg_h,0" instruction.
>   				 */
>   				if (size == BPF_DW && !fp->aux->verifier_zext)
> 


