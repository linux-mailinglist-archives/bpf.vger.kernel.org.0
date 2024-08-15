Return-Path: <bpf+bounces-37330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F73953D4C
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 00:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F561F223BF
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 22:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB42155733;
	Thu, 15 Aug 2024 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vbq4l4Ah"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE39B155353
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 22:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760360; cv=none; b=ewqpyXNcCgQ+YuaTuX9YfHMhHK0QyP2rjm7OPth535zDHxruZd2yXDjOuIeH+dgpDiQvi8GvKNmmZxF+m0WxRF1pH91SSQnRBYV70WrlrW3+e/26/rduadaMM3tVtZX44CP8+Qg+qhQ/NCcePBB4+WLoT608HIHMi72JFx2Zsks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760360; c=relaxed/simple;
	bh=AM87EI2dfxv5FWqktV75XqjPzLFT8Gh8lgY9qwiYtEA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PWm+/tzsglW41Pb8boV1XvcJdGZHv4LUaws+4BfwPnCNfRajrkYcJ8kFqnDgtyfkUSTlQ1pBGyPzBfWe/7t7bI/17b03TjRHCePBI/j1rlc090wpPjKwMtUwnDT8YcEtFDAOmKgAfWw2RfTpy1PLjO8548eaBJY/EKw0fhHlyf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vbq4l4Ah; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7c3d8f260easo993472a12.1
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 15:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723760358; x=1724365158; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AM87EI2dfxv5FWqktV75XqjPzLFT8Gh8lgY9qwiYtEA=;
        b=Vbq4l4Ah4WgaqkbjlK3kFYLq9OEANnL7hd06jtfKGay/zkfd7otABSrm3k0XhEQP7R
         t0SduF++yk1HrsXLOxlB55YHsdqRbZbFH/hueC7SAE+IhbHb/5LldG0HhHXDpw4lZGb9
         0MoesaArFkI87fgq+WxUnZ3NJA9Dksl8o5sCuNmwOqvOjlW0up1+JohLyghTvnzim1+q
         SJrCbGOPOnOPcPpxs6VUA76CbjyDljs4+VAq8oQcRnL8aogS1Bh1wnhtuKUENcM3wo6d
         ENfAyuqhh8G19iAJjeDgN+rzuNKBHZSaQIHk7gLiR5YO9kPrtA+jnMhg9W7Bj7dSro7U
         ZGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723760358; x=1724365158;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AM87EI2dfxv5FWqktV75XqjPzLFT8Gh8lgY9qwiYtEA=;
        b=i97axSKWKWnvGGX88D2aJh2NIjNRqzU3AISrQMPorkjjUiuMroN/7o+NbFMwyFoj2P
         Ra5SgU+6APAkPdv0upv4gDwwEkx/hGEpX5WJprBtD5SZ9qxC2YYq+9weyMz+jQLoaWMs
         7b6A9S4cAH3HjPkC+hgrFjaVx41VsQcv/ZjSfRO2g4pYqWzTcpK512lBJYFA0+Hv5jrk
         yabxF9Y5nkZdWLOBBJOv+LGm79T62Ho6o2dzd9ulfRSAvFvswRoyzd3d6YWv6C4X7CNf
         GB9WbBmP+9hmF/a5aR8lGIXNvY0Fv8X82iNghT/6Q8F3M7VdZJfKfI8NmDFrbK137xCo
         sIjA==
X-Gm-Message-State: AOJu0YxInUBAl6K1xohRLiOoRKi5IPJzWaxd52MRNUFroGZ4K9n58fL3
	btIu64bQFoP1LKqiTz1CV55eo7KOMtId3/DIoRmaUm7JZb0mnzwN5j66nlWSpGk=
X-Google-Smtp-Source: AGHT+IGCWhixtuaUSTiDi8SBGvHbOxX46u3m+bLl7z8hQNpYBEisN5KxdavxcGOxkmRXMRjGKRe36A==
X-Received: by 2002:a17:90a:6fe2:b0:2d3:d4eb:10e0 with SMTP id 98e67ed59e1d1-2d3e0f39057mr1058819a91.43.1723760358146;
        Thu, 15 Aug 2024 15:19:18 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3c74fbbsm324830a91.41.2024.08.15.15.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:19:17 -0700 (PDT)
Message-ID: <02461ecfdf2976881b349514b8ec743192b65b3e.camel@gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: validate jit behaviour for
 tail calls
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  hffilwlqm@gmail.com
Date: Thu, 15 Aug 2024 15:19:13 -0700
In-Reply-To: <CAEf4BzbvT7PO7ejSrH7JPPuYxDzXeK_E=3UNPVcTX9UhWN_hvQ@mail.gmail.com>
References: <20240809010518.1137758-1-eddyz87@gmail.com>
	 <20240809010518.1137758-5-eddyz87@gmail.com>
	 <CAEf4Bza97Ksce2XYiQrvzYC5Lnqz68xWM+JvDeKMfj5M3pr+Rg@mail.gmail.com>
	 <7925b20a052588f5b7b911ed10e23ba9fd56d4a4.camel@gmail.com>
	 <CAEf4BzZNN4YViWtv_LR996T4uw86MhcOLLkNFPMgb=Y8qpxK8w@mail.gmail.com>
	 <6d40ddcfbdf1bfecd7280d2a69f96eb66f20e692.camel@gmail.com>
	 <CAEf4BzbvT7PO7ejSrH7JPPuYxDzXeK_E=3UNPVcTX9UhWN_hvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-15 at 15:14 -0700, Andrii Nakryiko wrote:

[...]

> It is already special with a different flavor of regex. And I assume
> we won't have that many jit-testing tests, so yeah, could be adjusted,
> if necessary. But just in general, while __msg() works with large
> verifier logs, __jit() is much more narrow-focused, so even if it
> behaves differently from __msg() I don't really see much difference.
>=20
> But we also have __xlated() with similar semantics, so I'd say we
> should keep __jit() and __xlated() behaving similarly.

Ok, makes sense.


