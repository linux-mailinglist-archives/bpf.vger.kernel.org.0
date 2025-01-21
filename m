Return-Path: <bpf+bounces-49389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A40A17FB9
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 15:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5291665B6
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 14:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239C71F3FCC;
	Tue, 21 Jan 2025 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="VzKJV7c5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A5A1F3D2F
	for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737469569; cv=none; b=Z9KlQCA2nkuS1Sk1Cef892TKfdMYfHw+PXqLPCfUJwwCx0Je8FI76/A0hdV6/GqYjeqvABUZijPcn8zjlz+9Vk+6tyBtZiOtGYrSBLZtLZm20TfrMDVunTC1zbbV+vEZed6qlN7d/3u75ZL0lW8VjhjKbzg4j7GM+ZJ7yUo0OB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737469569; c=relaxed/simple;
	bh=Rjp+hmWDO5OTfT2ysMv61UtgN9kBNntHkBGEm553axg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aQOFu/VGeeVB5SVSvkDePl0RsX2preSZ0z6xz5/DN6KjysRk2klUfJ2J4tUNgrtXnorFYF6jXGrCpjFJbuZL4WnmcxNDYmgZIDmfdN1pg72MRzcxrDCtfthwLuTG27M3NRD+nlTyBRKYx3nqrdM4vCCZU4GiUDPbHQ3KjpfV3+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=VzKJV7c5; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaf57c2e0beso1130628966b.3
        for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 06:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1737469565; x=1738074365; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rjp+hmWDO5OTfT2ysMv61UtgN9kBNntHkBGEm553axg=;
        b=VzKJV7c5sszDBE+DajCUYyQthAweExG4XCb6BMSV9Evtb2gEIZbJog4hZjLVHWd1i6
         tzzSM+ZHes1R6Ip874NJNBmws8E9N/R6hxSUz2IG8bO3i1NvgEUHjglgcob5o8oCcUle
         gC3jz7PVEEhni6NQTY1YoyK6LuNK5cjlAfIXOeOYwts4J9iSYfI20TNrapTRW/wjbxRB
         1giGF2bjoV9eHj1oDwgjtEgJKxZPUL/Cj4QFjfSz46BNs+Z2J1ZuPfQuVXlKvXS3jD3C
         TXpIbSeRp/Uu1UPuWc8e9+E0EXCA/sFMpNYypQHGpejE83CcyvGCJZQ+gZX6PvxedoOG
         6ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737469565; x=1738074365;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rjp+hmWDO5OTfT2ysMv61UtgN9kBNntHkBGEm553axg=;
        b=f0DIrnu5CuyXBAs60hjjlV+mhC0XY7dK9kKt/rl/rbL4DCxv7Hkl+Cesprz5g73jPc
         6cRVhOzyHIQt8iZroZgreO+EEFDKJAdnf+yqrepGdAKfdJcqOBGIMFbwc27JWlDpeo2+
         NXBx+pHWx6SIFkqajXR7uc8KbNYQZrmECvOI/0/5JMqHFtdUXLsZcQRTKuXXLSo5vmGQ
         gu3cLllsECLfQ0ZJoWJlpIV0lLEOfjdb4uQQb+utIGMh76Biny/KzZua278s1J6+iycD
         qStjm4RS9Q4Jy5K+rw6OWUNedDe9hWGct2evoAz2y++/aGwfKlOUVzTYwpk/K1ryd8qV
         zFJA==
X-Gm-Message-State: AOJu0YxTBe2YOawNeI0bCiz4wc4mlv7y3+ilUe7f84ikx2XhP8cMyUp+
	gS71o0aUUlf5cQKSmTf33223oucAMn4H6iBXaQudZyJkOMfQ1S5ZBArnIA0dTDQ=
X-Gm-Gg: ASbGncst2RV2ieyGONZgusNmxf28SJIFqgwqD2qlT3OPI/fKXru3JijNvU0khHDW8El
	taMlok4vDLyM2DmKVpgOJtyRfahjZQA9Xpyr3nqi5lRplHD6yVuAk+ZWhgsICYRAkx+snYmmKG1
	UwTsc/53yCn57kBOFFaPvQnVt3zOjRop7Cgrc8EmqGUBgqQ7NYjYi7MjHQZp48e5XX61V5Q2QHq
	/UIdmBYIK2msTjzqloeLd0sWs5y89dnluffgXBu/n/QHBPBmdczF3Ggfkf9/g==
X-Google-Smtp-Source: AGHT+IHwlnK2zw9uivEKoPguTLSLMAAZPkuD0ILNy3EmWF7Ejd0QSjCd/rdjvIvH/M8AXJrGyDq9hg==
X-Received: by 2002:a17:907:9802:b0:aae:8491:bab5 with SMTP id a640c23a62f3a-ab38b30e1admr1420221266b.26.1737469564730;
        Tue, 21 Jan 2025 06:26:04 -0800 (PST)
Received: from cloudflare.com ([2a09:bac1:5b80:d60::38a:3e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384ce0172sm749653166b.44.2025.01.21.06.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 06:26:03 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org,  john.fastabend@gmail.com,  netdev@vger.kernel.org,
  martin.lau@linux.dev,  ast@kernel.org,  edumazet@google.com,
  davem@davemloft.net,  dsahern@kernel.org,  kuba@kernel.org,
  pabeni@redhat.com,  linux-kernel@vger.kernel.org,  song@kernel.org,
  andrii@kernel.org,  mhal@rbox.co,  yonghong.song@linux.dev,
  daniel@iogearbox.net,  xiyou.wangcong@gmail.com,  horms@kernel.org,
  corbet@lwn.net,  eddyz87@gmail.com,  cong.wang@bytedance.com,
  shuah@kernel.org,  mykolal@fb.com,  jolsa@kernel.org,  haoluo@google.com,
  sdf@fomichev.me,  kpsingh@kernel.org,  linux-doc@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v8 4/5] selftests/bpf: fix invalid flag of recv()
In-Reply-To: <20250121050707.55523-5-mrpre@163.com> (Jiayuan Chen's message of
	"Tue, 21 Jan 2025 13:07:06 +0800")
References: <20250121050707.55523-1-mrpre@163.com>
	<20250121050707.55523-5-mrpre@163.com>
Date: Tue, 21 Jan 2025 15:26:02 +0100
Message-ID: <87sepcgs5h.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 21, 2025 at 01:07 PM +08, Jiayuan Chen wrote:
> SOCK_NONBLOCK flag is only effective during socket creation, not during
> recv. Use MSG_DONTWAIT instead.
>
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---

Good catch.

Fixes: 1fa1fe8ff161 ("bpf, sockmap: Test shutdown() correctly exits epoll and recv()=0")
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

