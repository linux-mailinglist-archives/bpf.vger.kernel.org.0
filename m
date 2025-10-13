Return-Path: <bpf+bounces-70848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2CABD6C8F
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 01:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 692B33A46E2
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 23:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5F64C81;
	Mon, 13 Oct 2025 23:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV6k6MJ8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DF42C0F7C
	for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 23:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760399614; cv=none; b=hJtjz8CLojuSP/Q8e2qkm74K7pmzXDz6KlAf/XEgeAVE+h0rsuREWZvrbrG4VdWkBlUeVl1LKQ5bB02668qty+SJx0jhCZWeyfYy8U9C9P+YNTtX2O9GGkogsgCeN8zxthmWH5T6AYIn9clU4SavRWj18a0VzknNGe9Ey7ddW0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760399614; c=relaxed/simple;
	bh=RIEJrE0uCmjzvjs+seL8p1hc+jZaxiG+Mobd5Medcfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ilQZzifGJq+cuVhJhqk78iEbzkZEbQ4BPe/IzBCY2bYcDQJ5czWa3hKzNgosZAzEWEYJcexP2BvmIMWaxMgWlHJm22d1MLRXgUTVgZlYhlmOsCzjvtOc9cpIuTIaKq3qgI+XJulv3HhcfeRIqs932qaJA8ipnCB43S1ztVyZydg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cV6k6MJ8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e384dfde0so48514415e9.2
        for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 16:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760399611; x=1761004411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIEJrE0uCmjzvjs+seL8p1hc+jZaxiG+Mobd5Medcfg=;
        b=cV6k6MJ8Lkf+6yirLU4QU8uGgecETWdcE18APqUPjQ0tZQ6CIB5a3JifNbS1uMf19s
         EGOD0RdmRDkyptiaPBWXE8VljBXcJizxoSX5a1y0TvOQ6+jgrzdpopELTuB3WBLMvhuV
         81qjF9zVs/jf9GH4rOXpeUQKYbnq1b+6+ELgkGYR3nUsvqgr+Vg1kP7nYZxanGiAStgd
         /OaRUVSCsKunR7eHyHUMHWcb0xI+BoI9afEVAKSEeV06XDqMVORTC2om5+WDr+ml/j1C
         s9KFsPlFOLrOYV1LyQygoHvdsv9CvAVoEZWH9a8VTDx0bt87Hsmhk2l79ZSZtXaLs9y8
         W1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760399611; x=1761004411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIEJrE0uCmjzvjs+seL8p1hc+jZaxiG+Mobd5Medcfg=;
        b=AnMUJriWNKnrAVv+SUSxAOFcz5jZ8FcJo0TUbh3suJhaSyYUETw469eUEMohVPdCUh
         f94hcAxjFf8VJKTsn5wJ4orZ/6HM8KEreqnP44by7tNh2iK3j5EI4IBzXpRb+BR+txnW
         pj5uE6SYdGHJooxOeQbky/Kz6fnCD61Scw+q/c4UC60+nIfc57d+6uLVOyUM5XZ9EOZo
         nH3hgcpOwcX4HWf3mPCgsrts0w+eljgkRN2Ry/xBu4KNy+FcbFk0lSt54u9hbb07Uubo
         Tveexjywni7dCI4jmPgIsXGjyX+K/M5YeCJrdYlNZHoJ75EQyhQWTncwjmscYUQOylO0
         b9qg==
X-Forwarded-Encrypted: i=1; AJvYcCUe4w7W/BWV6grU+auz8AlxJ+wri2HuVwuOo1zt81xUhaY7WLWQeLnIZBU3fA/zAYW7Qr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRa2bnDM2rWlYhJ9P3Y6XGZgfYRyUp/2RAxK7+lDEf1weadEdu
	VyitYagyzytQphCFnA3XJJrLjOU2dJOcw7QAY1bCVMvsRd5JbOOE3Oc356kUCch/KvrEPzKwU08
	OHG6VLfM1z6OLtiKzqMs9vbapFn5TLpE=
X-Gm-Gg: ASbGncvWT8y9yLwSgtaiz7sPp04LmIne3ukY3winKAgEsqUNMttpMR5gFPGl0FAkRJK
	jvP6HHDhcY0mZVVyOIvMVaQdaOZvigh4JKaoiIbauTUtOPQDGHtM76cftPLrTTndIL88Fj63Cwj
	CP3RyNhmFK28rftFx5/2c47bmkM1Umo7gdRnKWofV9uT6jpu4/TkbBgyb9bjDZYzk2bjraKY0gj
	lku4Df0posSZ1/SwQ8iLpN4P28QQwqf/oVVgktawxxUoKANQ43FdI9cY0cj9mMdbWqXOQ==
X-Google-Smtp-Source: AGHT+IG7qgaqiANTI64fKq5fdmN3jYIEH7WORYmY4wbj4MgVRoihxDtESxflM1JUMa9Wy0M8r0UWCelXBUFZ0Hk7+LY=
X-Received: by 2002:a05:600c:5028:b0:46e:428a:b4c7 with SMTP id
 5b1f17b1804b1-46fa9af2ff1mr156663835e9.23.1760399610941; Mon, 13 Oct 2025
 16:53:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013131537.1927035-1-dolinux.peng@gmail.com> <CAEf4BzbABZPNJL6_rtpEhMmHFdO5pNbFTGzL7sXudqb5qkmjpg@mail.gmail.com>
In-Reply-To: <CAEf4BzbABZPNJL6_rtpEhMmHFdO5pNbFTGzL7sXudqb5qkmjpg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 13 Oct 2025 16:53:19 -0700
X-Gm-Features: AS18NWDSXnedfjS8OY9WIaDlY9RiYWa2my_cqlC8rCnw82wSbTJtgr_XZ-TyNvI
Message-ID: <CAADnVQJN7TA-HNSOV3LLEtHTHTNeqWyBWb+-Gwnj0+MLeF73TQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1] btf: Sort BTF types by name and kind to optimize
 btf_find_by_name_kind lookup
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: pengdonglin <dolinux.peng@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 4:40=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> Just a few observations (if we decide to do the sorting of BTF by name
> in the kernel):

iirc we discussed it in the past and decided to do sorting in pahole
and let the kernel verify whether it's sorted or not.
Then no extra memory is needed.
Or was that idea discarded for some reason?

