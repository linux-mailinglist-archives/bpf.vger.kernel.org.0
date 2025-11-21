Return-Path: <bpf+bounces-75212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 901E5C76BC6
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 01:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9A71F35729F
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 00:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB6D2253A1;
	Fri, 21 Nov 2025 00:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="it2hohtA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053C6221DAC
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 00:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684441; cv=none; b=UbvQDmefEL7d10kWuUfT5eiMiHWEEWm0nlRgQuTH8PXBOC3idzRtopK7g6nufCDDMmP3t+BMEBUfESP8CxG+BbjldRrRa0zZfmfRpW/VjK1Bn2wTuqagMaU3JgoBOqReNFAfjPW6hSOhl/2MrnHHlkIxo0dkFlXEnGHzy4rGX80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684441; c=relaxed/simple;
	bh=pa0em9G0vZiSztmaArfibgBvHukaXa3f+6mDgP2ktHU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DVNR20BFTY9/gjO+JOto4AzIAwLRXTfsxdLeU2eCXRzjb4cLOKy/ROW+AkwJxYJ0AvclmQ0e1eQ9NXZ4W1NXfWlBqbC46Ii1UybkP4cDV1s13bt7eo+lpKkZfMH/dWkUPnFtLqZNmTxS2NP/avcosx1qFDu5QOZKuAHcny7n+xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=it2hohtA; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-11b6bc976d6so2285951c88.0
        for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 16:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763684439; x=1764289239; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pa0em9G0vZiSztmaArfibgBvHukaXa3f+6mDgP2ktHU=;
        b=it2hohtABLcCayXelOtlcq6C0s5eSHBGc40uOgdBwgio+z9CiCuOJ+wL/sdvTUis/I
         lQ/ufx0MjZlAVPVwAHrBJaLFp8xt39/NRfOV9YVOfLOI6S5jXHRExc+lYeM0W3tmq8LQ
         5YBBJ/fCZvPI3ujIJRv1fI36rZtXlHM5BfySi2v5dAkDpqTgoQ8qU3wRPgErOts0A75O
         DLKftHuM+UhgzmpNSO310nDiGV/doW9Bh3drLECdRAGD1NonJS5Ay7a3mpMUTCKPqVip
         rjGKMM+/I3oXS2LNgR8rmEuMqOPloUcGIVRwTZmkUWqOxWLov9rtT2JygkSjEqLS7jWh
         FftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763684439; x=1764289239;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pa0em9G0vZiSztmaArfibgBvHukaXa3f+6mDgP2ktHU=;
        b=ta3N+t3AWKIl1yFi2onSw+EguksQPXb6qJOyp9J0vAph2ksiJJqbZ8SK1MhzRxiXDK
         C9e0b9sr+Bo5QsS5sFMip1074f6deF7OeArtH1q6An3zWQI5SY8N90TUabeNzFdTbSoj
         bXLM0oB5M+1gR8id9pGQwsotLzhaO7CcgHGJpi3oZ4fXeqiWhYTjKZvWDhFpiW95DjMR
         QKQoMiXDENcErPSYKjyAm8Bs7WtX8Xhe6T8YA1+7+57dUsWkJkuJdctafazN6+ISq1lu
         lACnhwIfxSvegYcPOjWDs+t4CvhiXucYp7W9QNjNx7BBUZSbf4A/iDZl/6K5l13QDpbx
         qI0g==
X-Forwarded-Encrypted: i=1; AJvYcCV1ZyCZg3XPHTDqodVGHQl+VcL/dB0OLIQKc1i/Ox0QhbbwCXOfNxgxLIWI1+UuKrnpa74=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbAzcJRKVakbsKLnTgvX+PyXkYL8FiQ+LE0FTs95OkqRkMb+kk
	aW64u4LUQyTKTfSQWyFYv3Iano/18kZThn5mIXGFhrrZfqoN0JF7/4QS
X-Gm-Gg: ASbGncvAFhKWL/dIOfQKDypSfj8O8+82WIQ02+BFSZFOsYiU7G+ubYMlAYh4nYyd/Qq
	Hw0fmbrtneu7MmVQolP8dGNc3tjr/rUzx/62x5JYxUVXs5vWpVK7i9nmDiTJmwJt4lpv25pvb+O
	vF+P5kPuXX3P0nJbOARV4HLFKImTB73pZslLy1XSURBdipQTxczwC75Xbj9eVORsyh0jgGfCqYg
	0YNKkY9BFvCzvekQ7kdDMKJ2bHco7mhyS2y5ZFsE0pSElTrf/R1swZwBovX4u1I5nr2eqZmgkvW
	coyfZD2+3COlGiA41YZIcKtHcD1LdRkhHk8URmKTccimF2HmUMUU3TVr0003LhqmE4Pbp4tydnu
	13C3/oiRdsxPp/zcMRcWeLbS4/7b5+0feTD/7oAYG0Kt3POIrH/Z5wkQzWo95LAvNJujKslBYLg
	I7tAeMWtSl6HYW6jXuBLXA38Zrc//J0OXRYqQ=
X-Google-Smtp-Source: AGHT+IGj3YxopiG+RX3C5bYzDknAbt7AWVcEA+p28I+i1HWsIDd5eIEdnw8SM5lbfGEvfx+UocKcjg==
X-Received: by 2002:a05:7022:ec17:b0:11b:9386:a382 with SMTP id a92af1059eb24-11c9cabc4f0mr194937c88.21.1763684438760;
        Thu, 20 Nov 2025 16:20:38 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:6e69:e358:27f9:ac0? ([2620:10d:c090:500::5:61f3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e5674csm16791755c88.8.2025.11.20.16.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 16:20:38 -0800 (PST)
Message-ID: <0cff721f227c29d62980dbfd2ac6bfbb3e34c7ba.camel@gmail.com>
Subject: Re: [RFC PATCH v7 2/7] selftests/bpf: Add test cases for
 btf__permute functionality
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: zhangxiaoqin@xiaomi.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org,  Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire
 <alan.maguire@oracle.com>, Song Liu <song@kernel.org>
Date: Thu, 20 Nov 2025 16:20:36 -0800
In-Reply-To: <20251119031531.1817099-3-dolinux.peng@gmail.com>
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
	 <20251119031531.1817099-3-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-19 at 11:15 +0800, Donglin Peng wrote:
> From: Donglin Peng <pengdonglin@xiaomi.com>
>=20
> This patch introduces test cases for the btf__permute function to ensure
> it works correctly with both base BTF and split BTF scenarios.
>=20
> The test suite includes:
> - test_permute_base: Validates permutation on base BTF
> - test_permute_split: Tests permutation on split BTF
> - test_permute_drop_base: Validates type dropping on base BTF
> - test_permute_drop_split: Tests type dropping on split BTF
> - test_permute_drop_dedup: Tests type dropping and deduping
>=20
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Song Liu <song@kernel.org>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> ---

Do we have an infrastructure for .btf_ext tests?

[...]

