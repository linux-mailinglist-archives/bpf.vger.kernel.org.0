Return-Path: <bpf+bounces-77215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F038CD2616
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 04:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76A83301A1ED
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 03:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96B72BE03B;
	Sat, 20 Dec 2025 03:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzZdlIRN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C918B28505E
	for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 03:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766201124; cv=none; b=MpP2ABFdcWoEVc797DVX2pUrNrtjJxmb/RTTw0HkupnrIOI4IakILSZmNOoJuigxWbLvhhXdlHYs7aeF0UClDeJaAyn3660wJGhMhLktgx0rjFMz+wO0pp01R4Ou/uit9NwuvO++MRot/e8VUb2pZwqqBmMGI79LtKNwZlHcF58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766201124; c=relaxed/simple;
	bh=giGocBaIiJgvhXKQgHIyoPiYCyJiwlKuUyOtVe5mTgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XC/xwkblZUJUS3YNAirBEwWMmmb0YSJx1KsXDakHCSAAKQIdi0Z35O9bu87wb6hNVPhzSLEitZZiJtqEHxZsjZg8UUi9eJLoK5S2oHqa4/7Sb9tF6Bl6Iille9wike2aLDv6lTRfnACHNM8EaS/KX+sR5HnlZGVohshj7lBGCm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzZdlIRN; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42e2d52c24dso1032904f8f.1
        for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 19:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766201121; x=1766805921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giGocBaIiJgvhXKQgHIyoPiYCyJiwlKuUyOtVe5mTgg=;
        b=BzZdlIRN+539VRmBmigNgwvTdU4ejDht16GIlrgoV8lTEag0VAITg6OHKdoYeKwm7l
         uE5bEN4lZfiX4ieD6aUpaBizvKSf/pctSM7b0kggDCz3d8XkIKYAmsk6xZjWRgr9S1Zy
         ZbvQdypo12H9Av4dkJmBNbzSMPweZSe3WkMqzkX86IZjdIV8cs/gL0MSAOe3AAZjFzjg
         DGEHwRBMb4Cq/vObGCXNgm2IhvvF06o+dwuKphYTepoCfPo/4zk2u2OjjSZKQBxvT7et
         UlKL/1c/ch8l1x3VrPCEZcIORMvEI/crH85u7fFkE3k1GCJOPYcLEl737X31I0Y9YPHh
         XazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766201121; x=1766805921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=giGocBaIiJgvhXKQgHIyoPiYCyJiwlKuUyOtVe5mTgg=;
        b=Ty5am01G3ksfSWTd/xeTlwqOUG2XgRQq1Ru11O1kzNNaKMf88zS2u7qAVDD7+Z/7D2
         yX0En0ZCYs5FsXH3Fl/Q8zQGZGmivS18FtPKa0o67LMhjVinBJz13ynH8CuStkgngPKu
         YcODx//GIHm+eT/R8/1SooJE5q0NF05ILeFebgeuA4macILroe67Z5xGzVJc26Ryz/mg
         4WPVma9nOYzAxDXOgPeg2r/t3WUMEwg8U+M4Y85fmsdiGeFLITb7NoT9PES8Dr0S2ymB
         Za6b8psMjE2TI9ixs/PvkXr40UOA5dNHmicdioUUv7x3j5/vI6zey/2aEq94yy4G0Zus
         gXDw==
X-Gm-Message-State: AOJu0YxhG1s6bxWpSz7KQfPdWS5oZU6Niab3Z28+r+qw1TDXSMnGYAIg
	arPJpKARHdKx6zhIV1ILaJei3bJSVdOerKaHeZ+V+NvS+2YNq//9+pzqJOEiwhuWkYQMfAn6rWd
	BD/6kyK/amkmqttzzqC6TZ7cL5YMbljw=
X-Gm-Gg: AY/fxX4g/S3rV2BkJVrRwM1kL4dLfUKMZn/CqRTSrtle3xaY067uTGggIayglBUlmFj
	0bsMq5s2kCkHcXzubJjzBkjEgA/nodbhXysIbZlb52yumUcU3HO5Kb5HVpG5siIdOzIbnIZzaNQ
	CNO0jxN5zZJQSC/btgMjOst55pREXxuWwaaYyVBf7Qq7OjIqVB+rWM9bvU0aXCdggeco3LSmzO0
	OKboUyi6PGR1XyvL/ADnhDtvarXTCoxasd0luHbaQoLcbh3Csezs8xEHmBGIwlkh5SFi7QK
X-Google-Smtp-Source: AGHT+IEfMqfGBPfQq4U5PTZOShPhGGBwEO04CSHAqPamxrIW9IsLVb0uN7vi5jcZiX1173snep+HcDClEw1zVY09+D0=
X-Received: by 2002:a5d:5f54:0:b0:431:907:f307 with SMTP id
 ffacd0b85a97d-4324e506ab1mr4829868f8f.48.1766201120937; Fri, 19 Dec 2025
 19:25:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219015750.23732-1-roman.gushchin@linux.dev> <87ike29s5r.fsf@linux.dev>
In-Reply-To: <87ike29s5r.fsf@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 19 Dec 2025 19:25:10 -0800
X-Gm-Features: AQt7F2rp4NL32Z0aIpL3dUf0AsQQrdIYNAD-89MuYw9ZNpbEPMobcrdtmcspWQo
Message-ID: <CAADnVQK26E47RF6TWKAXZizn1QQL1GBMx5MF9pqAA4+5ev1xWw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/6] mm: bpf kfuncs to access memcg data
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 9:40=E2=80=AFAM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> Roman Gushchin <roman.gushchin@linux.dev> writes:
>
> I believe it can go through the bpf tree or the mm tree.
>
> I'd slightly prefer the mm tree, simple because follow up bpf oom
> patches have more changes on the mm side.
>
> If Alexei, Daniel and Andrii is fine with it, Andrew, can you, please,
> pick them up?

mm tree has no CI and no ability to test bpf things,
so in mm tree it will dead weight while in bpf tree
it will be continuously tested.
So I don't really like the idea of anything bpf related
to being in some random trees.

