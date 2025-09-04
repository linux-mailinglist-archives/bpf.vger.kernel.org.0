Return-Path: <bpf+bounces-67480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A39B4445C
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 19:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953C1587F6C
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 17:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470E13148DA;
	Thu,  4 Sep 2025 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqkOPXvp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E143126DE;
	Thu,  4 Sep 2025 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757006939; cv=none; b=UestJBT/c4Pl6N8SifS2unQG2ktvRKMlM03NarurUTLC2wjuLqrpmGMrHeWySS2RwpLE8VxFAC63C3087uh7nEkgFg6OiZeO4b17npwt4n7uoe3jzMh/4Ck8b+WNrPZYQ8ULQ/Uy/10uz2hVm4AscpZEqF0Jk2WZDxcOWhp+XtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757006939; c=relaxed/simple;
	bh=ZU5d6/ptzJBLDmz675gVBayOMGnW+KFEBVu17nalDm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pxg6Aq+H3Q0w5gnVBKknhl49GSQhEeoriTaqQJsN7XpDw+XCr1q2pf0v1ikhNzlWvCkC5FkO4P5GXbsqEZWhsouoF3WCxGbhyMulvD1hiYTfACi2YqkEMAlBO+QqrnxyNFdPOJyOgOItC+BtHK5EGLespZJ5lMRaK3zl1JFGMm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqkOPXvp; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e98a18faa35so1500567276.0;
        Thu, 04 Sep 2025 10:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757006937; x=1757611737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZU5d6/ptzJBLDmz675gVBayOMGnW+KFEBVu17nalDm0=;
        b=TqkOPXvpmURbcBkkz8dq5ydXU/2p3kG3W1zDo1gVcSeHxLWSYu7XdXh8BiMKOcNDmR
         lkFgWv6iWa37Yun4L75X95yCewa2vi26A93C5+JEp+kmZtYy9GKh8QHRg02z/NZU3LJ8
         QL+PtWfs8SxUIYGfUViesOo+/ReNI/0PyzNK3qYUKNqfWzXQy381cdx9v/0sl7EO+zau
         bpjNUG1Opmksd+bfLAt2T1lc15kW9CcOM6rWiabEURQoF3a8mG2/mySlJcTo1+CILN3a
         LYVfVt75leyV4K1/B/yFhK0Z5/BcnLzot2AUepT5D0A1i4dzgMWAiaS++KRm5onxjZzm
         3+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757006937; x=1757611737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZU5d6/ptzJBLDmz675gVBayOMGnW+KFEBVu17nalDm0=;
        b=vPOiLvsdx7gRNl1p8+TaGLvMRTsehxJBtdNP2UpOe754+w77vL8y22rFZmysk3Kshi
         8QDzCWH2+Q/bXRJuTgZOYjNEI+7Wl/2fmnfX57+1jaiE3+SXPJi3erYvKMSbX085xnSz
         bThooKbtd8TUEf5DQ8Ukqj90XVDF5kbiyt522eoWWxEMAp23vYnVwSZ2xMshIM4B/Y+o
         eb88Up0Ob7bzFP2uLRiEZ+wFMPlPLyDlKKENGvDVTqpkvJwju7tFc9oeOiuOyWw1S56q
         KioHzIiV0vTpfKjndcckJ2dj3unBJF5y8ap9PtMhX2ciT1HneEIE2ZvFmMAHqzD82+yN
         Rb4A==
X-Forwarded-Encrypted: i=1; AJvYcCVTmibGY8NiQsL6ZxGNIwNsyDCqz4cf/c4ktQaPzVP3UC+JViQVQwz3b6Z9pbnVHWovLMMh7TZR@vger.kernel.org, AJvYcCVfc+n2los4xFyscGNVoKU1GO1KnyV2vjI/JaU+kMombauYEWpIG/bBZh+cBIEQM9tdlL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaPBYgOBHR9bg6rjy451mH7+Fb3gDBNW3eJkYXHxLMzrvtxuZa
	Saa+iVe5ypVYND9n5q46OZl0XKWgrX5U+jnPpBLyYLjlk5Kq/5LYFMrvBD6rGkipLzoem1Nxic2
	IeiLF7F3I+4JYxS/yEjlTTgEiPye6+R4=
X-Gm-Gg: ASbGnctZsdyT9e6DElfOKsUczL4CusF3M7/BmOPkuzrkQRC6BMnA2tDK+RErFsF3R+8
	nrU5hClQc72Fke3lZBTfOhCsJJEQvFawfmXh9NcT7ILuU31SzX9JaNQ9MaIN9N4r+urBstVXFyz
	F+VrEgm5T8eBZ+Q5nicYqazbh5sbqF0oS6QRiELgVoohTOy2/lJM/7yjMLaI/Hm7yvCIWHc2Xnx
	9f8bUZuOti5tvcwuA==
X-Google-Smtp-Source: AGHT+IGZkjEebBsHg4q1qHKMBW8uVQrFCfBXuYuhq0v6rgBgTZpn8KMJuoONzKYaXdaU8OFvFHohB+EIR+BMGXrYffM=
X-Received: by 2002:a05:690e:1487:b0:606:bf1f:fa54 with SMTP id
 956f58d0204a3-606bf200113mr3756665d50.17.1757006936906; Thu, 04 Sep 2025
 10:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825193918.3445531-1-ameryhung@gmail.com> <7695218f-2193-47f8-82ac-fc843a3a56b0@nvidia.com>
 <afdc16b0-fd53-4d4c-b322-09d1a0d8cb86@linux.dev>
In-Reply-To: <afdc16b0-fd53-4d4c-b322-09d1a0d8cb86@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 4 Sep 2025 10:28:45 -0700
X-Gm-Features: Ac12FXzOMQ6GKgY8tAOhev_Jj9tG-t7ccVAsMdGHh0wyZ4h_IRscTbWIbi26_Co
Message-ID: <CAMB2axO1Hb=pNMw8p2Ca+4XfVmDTA+TxbbXaD4G6kxUVEsHERg@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 0/7] Add kfunc bpf_xdp_pull_data
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nimrod Oren <noren@nvidia.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	kuba@kernel.org, martin.lau@kernel.org, mohsin.bashr@gmail.com, 
	saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, 
	maciej.fijalkowski@intel.com, kernel-team@meta.com, 
	Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 11:22=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 8/28/25 6:39 AM, Nimrod Oren wrote:
> > I'm currently working on a series that converts the xdp_native program
> > to use dynptr for accessing header data. If accepted, it should provide
> > better performance, since dynptr can access without copying the data.
>
> The bpf_xdp_adjust_tail is aware of xdp_buff_has_frags. Is there a reason=
 that
> bpf_xdp_adjust_head cannot handle frags also?

I am not aware of reasons that would stop this.

Are you suggesting another way to pop headers? E.g., use
bpf_xdp_adjust_head() to shrink the first frag from the front and call
bpf_xdp_store_bytes() to move the remaining headers

