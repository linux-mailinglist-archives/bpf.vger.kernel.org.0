Return-Path: <bpf+bounces-16828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B364D8062F0
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 00:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7741F2176E
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 23:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601F84121C;
	Tue,  5 Dec 2023 23:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCaNNxik"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A541AA
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 15:25:26 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c9f72176cfso43236891fa.2
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 15:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701818724; x=1702423524; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QEYsyIi+9u6mvaIr/kOBMsCkTwW3N/rKv79bJyUrLyY=;
        b=JCaNNxik07j4uJW3lkcBnim3+nyAzkWuwW50sM+nLTAOC8OZWMjerRa/GeJzWNMOcq
         ZvTlsclO+nn8k4t6MItG8N2DzER0ZJyZ35cocLY1lSXUlhkvEGj1xw7WCOgJ03hCRn72
         c2y+M17QoHN7L1Db66kqrbdVUhqOgcf6LChNRbEPUB5b0fq4RhjSrkrbqQGuepxwzpbQ
         lh/jvwY3qq+/XECt9QrPHz+xMa/6jTb2+2Ug4ccbz3smyuSF1lXZ/iAnW9EqDoWpTxGq
         tJnPAHLQ2A+S/jqcTmO06LJAfo+pKu0n/fnEUt+g+6i4zpSv/voj+wuH/PB8mX34XVD1
         Xouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701818724; x=1702423524;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QEYsyIi+9u6mvaIr/kOBMsCkTwW3N/rKv79bJyUrLyY=;
        b=Quly4+N0MQqYZsfgfT0k7oMV0nj6sU8vqhPP5RBlW0nYJjeLiOmxSxxqkJefNX13IC
         0BODDldI1JPrYIXNO5voqtvY9w5QamkG/WS94ftiSVLLMwe1ev1tWxiZ0uLw7HRtGg7H
         q163E3W8IGRuLKIpMoc1hFrp6SmkX+IZ8osQ3goEZmjLTVbYZT/bmghlij84HninGnJm
         Csrb4kU9+2iCyCZFexU7OOnpSC+rdHFOVuNZ+d43AHqrnsjPClIXzuOfNDHBJZhE5Ncd
         7u3zTXQU5TxMv5mn8RWKyRo1RPLXRoIn4W1UYlLHBx/Qsx7WZAhFWbB8O9PN9IXdvKHy
         OoIw==
X-Gm-Message-State: AOJu0Yy/VkwLimHqkVnpAecLJQ6IXShYbHhjMm4EW7wsC4ZieS261GYY
	iVDZf/Yf8qJI3u2cgPSVO8E=
X-Google-Smtp-Source: AGHT+IE0cXBit+kVtf16MUSVMlLYQBbH8Vf1RJ5VMltCAwQkD5Prhjt4e50qpRzkla+6DZaHo8bDng==
X-Received: by 2002:a2e:9919:0:b0:2c9:f1a2:f885 with SMTP id v25-20020a2e9919000000b002c9f1a2f885mr16754lji.60.1701818724185;
        Tue, 05 Dec 2023 15:25:24 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id b26-20020a05651c033a00b002c9f8626256sm1104215ljp.53.2023.12.05.15.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 15:25:23 -0800 (PST)
Message-ID: <e20134a3d4880218acc215ef8feed7e8a3b78fc6.camel@gmail.com>
Subject: Re: [PATCH bpf-next 03/13] bpf: tidy up exception callback
 management a bit
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Wed, 06 Dec 2023 01:25:22 +0200
In-Reply-To: <20231204233931.49758-4-andrii@kernel.org>
References: <20231204233931.49758-1-andrii@kernel.org>
	 <20231204233931.49758-4-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-12-04 at 15:39 -0800, Andrii Nakryiko wrote:
> Use the fact that we are passing subprog index around and have
> a corresponding struct bpf_subprog_info in bpf_verifier_env for each
> subprogram. We don't need to separately pass around a flag whether
> subprog is exception callback or not, each relevant verifier function
> can determine this using provided subprog index if we maintain
> bpf_subprog_info properly.
>=20
> Also move out exception callback-specific logic from
> btf_prepare_func_args(), keeping it generic. We can enforce all these
> restriction right before exception callback verification pass. We add
> out parameter, arg_cnt, for now, but this will be unnecessary with
> subsequent refactoring and will be removed.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


