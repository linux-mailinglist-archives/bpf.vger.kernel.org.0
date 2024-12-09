Return-Path: <bpf+bounces-46421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163BB9EA009
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 21:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C78165B78
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 20:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84769199230;
	Mon,  9 Dec 2024 20:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmvHLSne"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05E0198A11;
	Mon,  9 Dec 2024 20:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733774738; cv=none; b=U1q445juQU+rVsHb5m7t3RYOik2D/TmpInssplgBWOWM+cjvvMDFiftmNEVf8TjgnkLPvNQ2gJeNHWNIxYdTmoy5FCUJOrnCXASTiP5SkPuaY+tsm+hOwwtVCM9vwuoS8G7ySucKNtpfNJCu2Kv8solqm1R86dfrYodaLOm3uBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733774738; c=relaxed/simple;
	bh=WIl+qMl6wI4H1k/8Ts2Y8SWscrJvMfXwkYz/iHlg3yQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gQhmovoNDvVUUbtWWsQ1/uZa30Cp1/vPI32dPQNqUrFNOrWnx9OCKoALR94uqgMR34csEGORJXK78zyaIhUM+1ivnOhf0WgGkoKBA967kgEVnUBkPZQFX1I7SrTGylTN3DjU5Rw1i2vQBA25W6FBdUkvN/q9btMTP12mYNdcbyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmvHLSne; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-725db141410so1624879b3a.2;
        Mon, 09 Dec 2024 12:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733774736; x=1734379536; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WIl+qMl6wI4H1k/8Ts2Y8SWscrJvMfXwkYz/iHlg3yQ=;
        b=MmvHLSnen4g0sRNOQyMHKz45Euw8wr7kQm30G9mD3i3e3X7c9Wjzx9UzD+Wmupe+SO
         GKZa7uf3UBdbNO1wdGzv8WN7oVTH1ZD98GAC4X88ViJCdGcUCwalF8Z2kD6OU3SptmTp
         MmSy9KZU2yvCFZfI5uLkNijCFWExV4oHdpjIWmwrOU9Ki38vVDIo/r1q09m3jko5kLga
         ADo48idUrcITV9WYNN0iiScUbPpw96VPx+fmVUkNKZ5ZY5FMYpmn0E79GGSd/0EQtXGD
         WfJx3498XUU0x6D4F7sQwuqjefehHjCZ8LDgmc0FlN2B//gd5qAKgArZS+SjKEWauPYj
         qxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733774736; x=1734379536;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WIl+qMl6wI4H1k/8Ts2Y8SWscrJvMfXwkYz/iHlg3yQ=;
        b=g7a1G5N7N0PZSck7iINZ4e0sFMg544jf4rA1OnnahdinOMma85QQ0GvbVYqpiXKBsE
         utvn/CokUNhvgtzMm5mNvrmWBK952M++RidDPgemC2wSa4dg0kWStJaIL1lcuUL8xWki
         4/tnn//mO+9psjNMADXN+4tDEXfgK3CFvHryaaKqDkh0YmVccTAImZoQwgFW5pF/1Ap1
         ZbzukfI/pstIpX420UXYB8/IXVT8gjvnm1E7o6MLECOttxsulv0EH+15MQD1JwMgTBcE
         sqWkwBrx3HKklS+4NO2Eppf8GokhUhwpgQlrU8Zpk4hgxK87nWKKhjqi/gIldsILA2wJ
         HolA==
X-Forwarded-Encrypted: i=1; AJvYcCV0Nx7HbXzB1oPT+WZpAMPpqd8aB3ptE6LbbDxjxxw5ueWvGTTX/fN7r/zWKpaEVJr9iLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZnObo6FNEPi4Qjh0BtlKggQZZSGVv1NbIfiMQODQwaXC/Odt/
	3QH42sxrsvQj2lkx44QEqax/8p6ckQVJvY1G37NeiuBx47fBAj//
X-Gm-Gg: ASbGncv/AvlnI14JCWkP+bWzfuuPfYgmaiNV0ZzGTTC0E3d0qh1yI51rO94zzqJGNTR
	P4xmBF0FJu+qaY/LmxkVSDDY+/WZzRm3iFfx1LhzciUqUrdOK/DMO6UrY3QLH50cpnBWMBX713m
	FGZBMbmI7I0KK3qg0YurKi/gNoeSbtbqLMe0PUW2BcCC7WSORWrXtYFFh5Zc7nHjPP1mfEPKZ0Y
	/G3SgHZkg51VivzMtgNRQSrhoXC+QcZQOA6Qy/gNFHqNjc=
X-Google-Smtp-Source: AGHT+IHlrixcmIjFrk7n5B2dZSTFDfNUfPU6cmGanHT94MzVpA2aHZ56T+Yhf2KfdHeVILYqVBgx1Q==
X-Received: by 2002:a05:6a00:1990:b0:726:f7c9:7b1e with SMTP id d2e1a72fcca58-7273cb1adb0mr2583506b3a.13.1733774735761;
        Mon, 09 Dec 2024 12:05:35 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e67ec452sm3064458b3a.179.2024.12.09.12.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 12:05:35 -0800 (PST)
Message-ID: <094b626d44e817240ae8e44b6f7933b13c26d879.camel@gmail.com>
Subject: Re: [PATCH dwarves v1] pahole: generate "bpf_fastcall" decl tags
 for eligible kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, arnaldo.melo@gmail.com, bpf@vger.kernel.org, 
	kernel-team@fb.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, 	yonghong.song@linux.dev, martin.lau@linux.dev
Date: Mon, 09 Dec 2024 12:05:30 -0800
In-Reply-To: <Z1dFXVFYmQ-nHSVO@x1>
References: <20240916091921.2929615-1-eddyz87@gmail.com>
	 <Z1dFXVFYmQ-nHSVO@x1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-12-09 at 16:30 -0300, Arnaldo Carvalho de Melo wrote:

[...]

> Next time adding a feature in the BTF encoder, please consider adding
> the support for the BTF loader and the pretty printer, so that we can
> capture that info and produce compileable output that has those tags.
>=20
> I'll do it when I get some free time.

Hi Arnaldo,

I'll handle this, sorry for inconvenience.

Thanks,
Eduard


