Return-Path: <bpf+bounces-42681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 131859A9171
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 22:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6CB1F22F0B
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 20:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBB81FEFA6;
	Mon, 21 Oct 2024 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIcLEr39"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04D51FEFA1
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543471; cv=none; b=fZmR1W2YcpqUHncZuFvZnR0tW+GRutyp0FIKcZLMwtSdcnxGtTer6SFAtPH9sWjUyLyc6fXRkqfQiTuXSxJ6Beg3RN1hXSAGsXz+SKr+izxYZdpwc8tU1gITt+H21SQPRoxfLrrll4rTIh5BPu21GGvqz6lojxdhrRiHz2+Zy4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543471; c=relaxed/simple;
	bh=w/gd0WxST5KG3tTolpQMohVIWdnehK2lpveQZqeBuIs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pn6uROvcyQ+msxX/AZyQo12kENciLA2D2WRsLCKL69yrXrsQ2WfAvA+aiK9M1W7sz6wuja8iXbzmuP+GFMePMXmHPdBqnGlEEGD99j3RLn+FdAyuS05ERXMdEPGYALHide6zH2gqSwqNR+/+Xt488dIogQUMvyaAN01BAMdXWkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIcLEr39; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c9978a221so56314705ad.1
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 13:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729543469; x=1730148269; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w/gd0WxST5KG3tTolpQMohVIWdnehK2lpveQZqeBuIs=;
        b=JIcLEr394ZZylWe2btz2bX+tsmeU+Ci592FTb9MgWWpR2JbVPRq98d2UPS+VEMNfOX
         MMRMnlqhVv9toEAMAAQ4vNwFTQustMD1jX0CTDZdotaUXvemdIk9TjpTbRyepWnIluX+
         oMpCRI0QQm0D6wVShhlUZ9tvvgibfd0Ugf5Ty6e/mZ2rcAACfGH3dbaMspxTb4KvBKfK
         3swkIaWbfqA50DB9ZWgdNmMIWiSOpXDzL6maKK9cBlHb9f/ly/JG+ARp8aWXyk8zMm9W
         wy8YTC3chRzPq+f52ngeZU2bKdXtZWomhU0bk8fSTVoG5/2iUvHI7QYI5CImEX/2VjgM
         cgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729543469; x=1730148269;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w/gd0WxST5KG3tTolpQMohVIWdnehK2lpveQZqeBuIs=;
        b=NDdpN7AK4P4z0JKDWM2yVqPCzx5Ymw+AsqaPJILFSyRU6H6Gn/pcUQs4oqbVSt6fuX
         spD0016tAnoUVCeHoWBS/VjOhqJGbrcYYYDbw/Ufb69QtG1VVUxwPMU1tc1KoJdIeKdG
         IGDqgNptdlfUdh4DBmcZGyKKVF2VnFpUL9n64spzgYrvhnpZgIBavmq8gS62NYRfkUuq
         Ab8eLMyjc2BMAIMukdW5qWVEOrmdtAkFSBY9VPXkLEY6lEpItaQngBs6IJhnr7fZ28pj
         t1F/PSv1oOBEuFyh1Fj6uBE7RWkTY9Md4NLIu38TWrjeJwJ72HsptD3famrw2ShtP0I6
         1Jkg==
X-Forwarded-Encrypted: i=1; AJvYcCWwT94PIdH93wyUiqvzhBsR9zAIaEKBnyX1TUdP0LXQHTQ6T47GOb3jlGvUCZouFxqXbk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIRkcBZ3GePvw05U1xfAPLmLBKWiBzWMlSB6rgGw1LQJ+Mb0gA
	2YGnQ14FjVEmFD2yTN6H+MUhqm9aMh0EBDap4veWjjpeAxV6SxEh
X-Google-Smtp-Source: AGHT+IErt5HmWvKssC5IUgZGzC8at792EaohLDPHcqkdaRJeTNZCh/wtby9lAuR/OEtQCmrNtmSjjw==
X-Received: by 2002:a17:903:946:b0:20c:e6e4:9daf with SMTP id d9443c01a7336-20e5a737152mr168701255ad.13.1729543468859;
        Mon, 21 Oct 2024 13:44:28 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0de3c3sm30104035ad.207.2024.10.21.13.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 13:44:28 -0700 (PDT)
Message-ID: <167627ec65ea21df19a6acefe186d591aaeef978.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: increase verifier log limit in
 veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa
 <olsajiri@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, Mykyta Yatsenko <yatsenko@meta.com>
Date: Mon, 21 Oct 2024 13:44:23 -0700
In-Reply-To: <CAEf4BzZ6b7drmHJN=Sf8Mjq6VB1Drg5g0LyeyN4URCRS63qTzA@mail.gmail.com>
References: <20241021141616.95160-1-mykyta.yatsenko5@gmail.com>
	 <ZxaE_C_Im9-I8OSa@krava>
	 <CAEf4BzZ6b7drmHJN=Sf8Mjq6VB1Drg5g0LyeyN4URCRS63qTzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-21 at 13:14 -0700, Andrii Nakryiko wrote:
> On Mon, Oct 21, 2024 at 9:44=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wr=
ote:

[...]

> > IIUC this would try to use 1GB by default? seems to agresive.. could we=
 perhaps
> > do that gradually and double the size on each failed load attempt?
>=20
> The idea is that verifier will only page in as many pages as there is
> an actual log content (which normally would be much smaller than a
> full 1GB). Doing gradual size increase is actually pretty annoying in
> terms of how the code and logic is structured. So I think this
> approach is fine, overall.

As far as I understand, this feature is most useful for programs that
are close to 1M instructions limit. Such programs easily produce huge
logs. E.g. selftest pyperf600.bpf.o takes 627,288 instructions to
verify and generates 281MB of log. I agree with Andrii, that
allocating 1G for this purpose seems reasonable.

[...]


