Return-Path: <bpf+bounces-46548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2D79EB9BE
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 20:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B81A2827E2
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 19:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050BE2046B8;
	Tue, 10 Dec 2024 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LADuOPmo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0266DA94D;
	Tue, 10 Dec 2024 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733857317; cv=none; b=SnBSZ6Pi5gvITdYLCddYKaX16dwO+PIveEG5wbbdO03iVIZp32xveV8DggWeXntEqaRYkdE4JTNd44HwiklFfkIXbbzjhCls5R406+JM3bHrCcxWoyMYTvjbRIPpIs77vQ6uhBfV/1AhcmqEphtrbu7knOhO9fRfggHwBPf3A7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733857317; c=relaxed/simple;
	bh=arEki5t3poRBe/OeDf1cpXsNt+oW0ert89Ja4y+auik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5rMisfZV0fRTYkcTeNejmgwiDAZPVq6VXLGaeEFd2H5CKaXSlmhQTbfljEknBlBDsnG2ZTfq+OFxaxU/GJGORduVJ5WUOHRHBJ8T2wY7CRjm7gdF/dgzaWQtxh4+4nCZ2SzUHPPK155zAIdb2WalLrk7IW4+kWGW1xvYU9dUvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LADuOPmo; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4361a50e337so4481325e9.0;
        Tue, 10 Dec 2024 11:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733857314; x=1734462114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNuyOvfbEwD7NiMub6WxaAZ34DRYkXlSjyNSk/huFWA=;
        b=LADuOPmo7NDNJ4aQs44cvLhrYfRNcyNnX4N7KObDIPpEzaovbZYuXqFCPEQERRq7jz
         39WVLatqongGOK0ZTIFchsBaEa1BFOcikIu85rYiEPZzBOmnoapVP3sCHY6YOilrVoaH
         GhsLgEuvMnnLtHXTrevfDdwc9J0iR0xIlvspf3eQhITktd366oPKmeKsHBISIc3tLsv6
         rb/YFvlJ/2///8Iv6e5VgiyUfjsScfzQ8FEBgXY4Ar4nlwWkTk+msjtjKtGDnkxTF5i2
         L69sEnuH5R7FKZ6xg4K+FNMRc4pE9UqWoAixOzHccZsWYYuJ1ZZ1RxJRJ/CM8jMhBTFl
         lPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733857314; x=1734462114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNuyOvfbEwD7NiMub6WxaAZ34DRYkXlSjyNSk/huFWA=;
        b=nG1kBEqJdpiFLtyG5JUE7J5X132XDhZV6YMaU2woRHqmP29KqSnTPczocyKTCvg221
         wqnEbAPf5J0enl4pIFgJyrMB/6jb1gWALAh4fnbjuWl6nrD6msgQV2H+emaBVdeBVEUb
         t9a+X1Bu29x9WE6rw4JuywtDaZWIFLYzy5M+KTYQuOsMCDvnf//lgjaOXtclaGVXc5jm
         7f2P9CDx8mfV3xP+fIzn4aTP1ncbTiyIXXvolxbxwWS+GdH37CVVTV9mfm/tBObVxu8h
         E7HOansE8LAiwTX01YCrt1U2U6v5SkKUlsmzUdUaYmdaFB+m6XSI8DOMQn2Rw5pnF/oJ
         yWoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU659013zS7k8vfEOKBNK4bWPl39gybtUuGLB5jQQpOjUIhq99s4IW1He6SzV809WnZco0=@vger.kernel.org, AJvYcCVF/F2jgOUeY1xeId9f4qWxIL4a+FTDZH5QpR0xuQV3p0Mqj9xeogrH2JczOvW7BNwAgEkwCEyLJxjR5PB4@vger.kernel.org
X-Gm-Message-State: AOJu0YyW2wBi+3kJLDMYfC0JwHgdVuTJ6+u9KUSa3RMk9xjpegVV0uTa
	eZimz1PpUEf3AGcxLAhVz1B9OPJQ3tkxH/nShE0KwSDYuN7YOMrO4yPYaSI11MKPdEzqyMQFHXt
	q/07sp9CV/mJ5oxEwIzk5d8ZT/og=
X-Gm-Gg: ASbGnctd/gYmVG4v11LCqdqJDhKCBzuVWOALRwTe9/S1UZiJEaWfZ4J5H5l3AFrn04Q
	9/KhytJ0ywjmZipkruNX0Lpdtu48S4PqXoWxqNMPWJRUFmUUrPPM=
X-Google-Smtp-Source: AGHT+IGOBdssKOPgCFpd8K90OtWdYFWuEk8u05HWK7O7siUB2bak4otDXjRcyvgcB4E6b2V+wH+t19p2T6Yp3I5xByM=
X-Received: by 2002:a05:600c:1554:b0:434:a07d:b709 with SMTP id
 5b1f17b1804b1-434fffd7955mr48903645e9.29.1733857313965; Tue, 10 Dec 2024
 11:01:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210185321.23144-1-pvkumar5749404@gmail.com>
In-Reply-To: <20241210185321.23144-1-pvkumar5749404@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Dec 2024 11:01:43 -0800
Message-ID: <CAADnVQJvhkDe9t4GuoHrApBeJ+q7ROjq-665CGbusMA-r+tBdQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] BPF-Helpers : Correct spelling mistake
To: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 10:53=E2=80=AFAM Prabhav Kumar Vaish
<pvkumar5749404@gmail.com> wrote:
>
> Changes :
>         - "unsinged" is spelled correctly to "unsigned"

Is that the only typo in that file?
I doubt it.
Fix them all in one patch.

pw-bot: cr

