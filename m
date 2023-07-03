Return-Path: <bpf+bounces-3886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 508C87460FF
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 18:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9FB2280933
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 16:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AE7100DB;
	Mon,  3 Jul 2023 16:54:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7879A101C0
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 16:54:05 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B640E59;
	Mon,  3 Jul 2023 09:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=UPHKo8guvj/2wEUMDLhfEXpJf9TVh5eXRfSHFXQcHBA=; b=jfLhYm02QkWxLFM1DOGstKUnu6
	vxf4OfAXc0eXw20E7wZh78gLJoqMhjFRf/oU62RDRD0Y/siwM0bgtmZ2kq6sibM99aYXU+CHQcQNG
	rsU+M1SG1uwJ8ms67fo8/t12u2b/say9bs/bvTXz8HTeMLMaopAm7hv8D+at9DT82tvwE4fnbVl0j
	Mr2pP4eUO2b6zNAQJWYulIwvGpE9KSM3gh5FGaABJool2Q2cgG2uRO1EnHXaU9fPk74wyndzGM+Wb
	aM7QxDIu3VBNC8i8qyxowsL0+J2cvUHwF9GfMOkD2QXk8TlYOgIxcjSGkz6LErLQKuS1MV/WG/x1g
	UlY2fz/g==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qGMoH-0007Ti-On; Mon, 03 Jul 2023 18:53:57 +0200
Received: from [178.197.249.52] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qGMoH-000UR3-82; Mon, 03 Jul 2023 18:53:57 +0200
Subject: Re: [PATCH v3] btf: warn but return no error for NULL btf from
 __register_btf_kfunc_id_set()
To: SeongJae Park <sj@kernel.org>
Cc: Alexander.Egorenkov@ibm.com, ast@kernel.org, jolsa@kernel.org,
 martin.lau@linux.dev, memxor@gmail.com, olsajiri@gmail.com,
 bpf@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230701171447.56464-1-sj@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e1d10b8b-e9f2-267f-c8d8-55d977349c5b@iogearbox.net>
Date: Mon, 3 Jul 2023 18:53:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230701171447.56464-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26958/Mon Jul  3 09:29:03 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/1/23 7:14 PM, SeongJae Park wrote:
> __register_btf_kfunc_id_set() assumes .BTF to be part of the module's
> .ko file if CONFIG_DEBUG_INFO_BTF is enabled.  If that's not the case,
> the function prints an error message and return an error.  As a result,
> such modules cannot be loaded.
> 
> However, the section could be stripped out during a build process.  It
> would be better to let the modules loaded, because their basic
> functionalities have no problem[1], though the BTF functionalities will
> not be supported.  Make the function to lower the level of the message
> from error to warn, and return no error.
> 
> [1] https://lore.kernel.org/bpf/20220219082037.ow2kbq5brktf4f2u@apollo.legion/
> 
> Reported-by: Alexander Egorenkov <Alexander.Egorenkov@ibm.com>
> Link: https://lore.kernel.org/bpf/87y228q66f.fsf@oc8242746057.ibm.com/
> Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Link: https://lore.kernel.org/bpf/20220219082037.ow2kbq5brktf4f2u@apollo.legion/
> Fixes: c446fdacb10d ("bpf: fix register_btf_kfunc_id_set for !CONFIG_DEBUG_INFO_BTF")
> Cc: <stable@vger.kernel.org> # 5.18.x
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
> 
> Changes from v2
> (https://lore.kernel.org/bpf/20230628164611.83038-1-sj@kernel.org/)
> - Keep the error for vmlinux case.

Looks good, applied to bpf, thanks!

