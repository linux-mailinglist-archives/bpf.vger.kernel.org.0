Return-Path: <bpf+bounces-22920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F263E86B8D6
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 21:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B52C1C20D50
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 20:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B758D5E09E;
	Wed, 28 Feb 2024 20:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQPCglWW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5905E069
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 20:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709151011; cv=none; b=MvUy/vLac8HHv+w22whLygQjJWLwCwvQ3Ni9y6VJrFgcuF0dhM+jvHb2OB7Id3aUwJ8PENIbVFp/0DSO7ZX7GjUZyIA7P3L1N3o7dOxfV4+Dz+EoOngoBcuDGYGcRuFeLhEiteH7Kssew9biMXTkgXh1cTSlK4Hh72ZPaKEgZDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709151011; c=relaxed/simple;
	bh=FeyVrUX+96v1l5/8yTeFi0Mmf1ev47z6G+f+YlBXaw8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kKtaErLP8c2p/WiESGIH6aaMJ4grn0KiHpNIg8MgGjHMLb+848q70NQ/rC0jiFoQAbI4TARy6qqlMmbNYmawRB49ZWNbOl2DhdGGW2RVSJhazqg7wSrjhTxPwKhhWIpQCcviKTtrT/6mHQRXXDYeT5O5s3BuTKr0Ka1zbGaT+Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQPCglWW; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513235b5975so67114e87.2
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 12:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709151008; x=1709755808; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3vhHhauREfnEFucI1x9TofyAqCWOfvzm3e3lgc87H6s=;
        b=AQPCglWWZII6eOlRIaNS91lYEYAegxRiXpCawzz4SrYHdbA6QMTKk7LioYDQRRJ/L3
         l0OSytPjbHim3gzO1UJ6il4tpGI8qhJ9cHe3G1/XPcuvccBxeWB4qsTr7Cx/WUi01P+G
         lsNu73UkHcZJCLbdGVI+V32NqkC/67kLpdo6frPfFunVqq8vLzYtIbRaoIwhQMgn5z8j
         lLv8nU5ZWXxy2jiLLoY/d9+x3H89Ge9wvjXxbsCldEQS3miNYOiwloxlWQD9ndqWkQPO
         FLKxQS1Y8T7YeacdMzeRemDuM7nSmfC0SuQ8stkJSljunsOrSxEvCWVj3K4FTtxlBXRy
         SopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709151008; x=1709755808;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3vhHhauREfnEFucI1x9TofyAqCWOfvzm3e3lgc87H6s=;
        b=fRz/uJiLsPmOKVCAjS80rW+WR8e5rTVUbXWtOb+s1WhsgnqdBPrvqRp/RW7/5WA/vA
         nKkWq+Pwub/ZhzvKphYMnIpXx/AprDBzcPn33/LL1L7TFWUwOAszlYDOj68vPMMOPgFM
         y8K3nKHZ2cfwr6j8OEJxXP1ZR6rbfB8bVEz8DuaENzzA5okx+bvewJkSBSmeju1RMBeJ
         rk+j9BgB9ORQSsl2QhH98FEHXMAmlQJV1fkf7svPH5Rv6K6exXLVykwv9M6zmKXVGnBu
         OzKzS2CCqgM7ej3xc+/RRfyfLpwWd22UtZpcW0hU7MzqrqrQILeRucBEO4AAvQfNbQ3l
         0Gog==
X-Gm-Message-State: AOJu0YzmGh6aCo00Scc9/fWPxO8+EgKUL7syVFsemgj3XaJ6APqAEwwA
	26coEMwalRcPszLLrX/S2pa6a7/D7IrmQIg4vadr4mzsRhlgzlUN
X-Google-Smtp-Source: AGHT+IFnXpKE28WMSYN6QuJzV7LB1BCMG8mEgySMjAS6JJQPegbjheKp2SBRNFVpi92ZWSpq+8ebSA==
X-Received: by 2002:a05:6512:483:b0:512:d5c9:c117 with SMTP id v3-20020a056512048300b00512d5c9c117mr22627lfq.1.1709151007497;
        Wed, 28 Feb 2024 12:10:07 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id d10-20020ac244ca000000b0051321139817sm26856lfm.47.2024.02.28.12.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 12:10:07 -0800 (PST)
Message-ID: <71d0f6c6477df8e7591bb457449e8690962266cd.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 8/8] selftests/bpf: tests for struct_ops
 autoload/autocreate toggling
From: Eduard Zingerman <eddyz87@gmail.com>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev
Date: Wed, 28 Feb 2024 22:10:00 +0200
In-Reply-To: <20240228183658.GJ148327@maniforge>
References: <20240227204556.17524-1-eddyz87@gmail.com>
	 <20240227204556.17524-9-eddyz87@gmail.com>
	 <20240228183658.GJ148327@maniforge>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-28 at 12:36 -0600, David Vernet wrote:
[...]

> > +	/* testmod_1 off, testmod_2 off,
> > +	 * setting same state several times should not confuse internal state=
.
> > +	 */
> > +	bpf_map__set_autocreate(testmod_2, false);
> > +	bpf_map__set_autocreate(testmod_2, false);
>=20
> Duplicate line

This was intended, to check that reference counter is not over/under-satura=
ted.

But this does not matter, as the test would not be in v2 if I take
Martin's suggestion in [0].

[0] https://lore.kernel.org/bpf/1e95162a-a8d7-44e6-bc63-999df8cae987@linux.=
dev/

[...]

