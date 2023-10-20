Return-Path: <bpf+bounces-12784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DA07D0690
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 04:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC15EB21467
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 02:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553CD811;
	Fri, 20 Oct 2023 02:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="UjyXydjx"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC51369
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 02:42:14 +0000 (UTC)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547CF124
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 19:42:13 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-457c82cd87bso126647137.0
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 19:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1697769732; x=1698374532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVA5fSjdA9V5Jo7c0rF1Ke9rT3L+nX0I3OmN+3HgEuw=;
        b=UjyXydjxMYgl7nGK800ipjdFl5yJM3BNar6MUG3GLLI4+k/A1vSDiBKsvB1lrZK0jj
         CBaHz8ZQEarVFtrBO6QlCTMgdY+vb05N0s3FsBCOQGy6JkYczkAk8WvFS90waZ9VNqM4
         iYJxWM9m+9TxZYddp6+Ee5+1guGxeS0joL+jrFrk7/MK9+uChvcU+JmkoNFLUM822a/T
         at3Au4mbPlaEofQydyM+uAUhdzgOBSOttW0b9rHBn509pzIZnDMgRlSIoz03FnclOrva
         KBKiaO4QDcZcVgHwXcsLUuqu0YRVIRD9mZY1hP/yXsFnSR/TPAYTrl7C/6tEYUHJ2cdf
         iKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697769732; x=1698374532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVA5fSjdA9V5Jo7c0rF1Ke9rT3L+nX0I3OmN+3HgEuw=;
        b=Dbmc9j/OPh6abZAmI7m/a8d1j7r/6944cx09edBSKlPdIqlr9V/uUIPrOrxoQN+udZ
         A3vGWm/F3f/s8O62J1u6Vz3/wl0oILDRbQu3abW5+xaEing0eV7KyKSSGd+tlp5p73CK
         WmAMTm3y2SByDdc4f7Wjg4uMe4cTchFMZZJjdYmVLxC1KyMsuPV7S+sphEWewA4UDD1L
         qOkkR2eSashfjfBQvOM8qOb2KIF/71V1KP5daO00IpFbS8xAfwZiBNWKbCTGXpLeq3Mk
         IgGg86nsacFpivKAoPetrIVNporqFtHtP3y3GJZBxYbCLIYEyRP1IGxwWmeDcajYY0pW
         npjQ==
X-Gm-Message-State: AOJu0Yx2ltN5fXjLqOs4X6N/lCy4vmM5xLEgLr3vzCHxrd3IpvlbDpif
	eUmW4QLyjw9pHg7RL1n6yODGY1ZE3KkcrlUJWUwXf511IVW+UXAe
X-Google-Smtp-Source: AGHT+IGDCGb5MI1ezH7+uuu1/7puQhR8na0yn2tuohMCKuEiXELqjEyNCbHP/8zBSiAq72R00sLq4ahOHMZvHM1sSbs=
X-Received: by 2002:a67:c38b:0:b0:457:eee6:c105 with SMTP id
 s11-20020a67c38b000000b00457eee6c105mr649257vsj.8.1697769732381; Thu, 19 Oct
 2023 19:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231002142001.3223261-1-hawkinsw@obs.cr> <ZTDGPJFegKuwZiOe@infradead.org>
In-Reply-To: <ZTDGPJFegKuwZiOe@infradead.org>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Thu, 19 Oct 2023 22:42:01 -0400
Message-ID: <CADx9qWhTXgKxBpjY47ufhfs=7Fb+mxGULgXo=JrEyUicZ5JP9g@mail.gmail.com>
Subject: Re: [Bpf] [PATCH] bpf, docs: Add additional ABI working draft base text
To: Christoph Hellwig <hch@infradead.org>
Cc: bpf@ietf.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 2:01=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> A little style nitpick on top of all the useful comments from
> David:
>
> > +An application binary interface (ABI) defines the requirements that on=
e or more binary software
>
> Text documents and any other bulky texts should be spaces to 80
> characters.  This should just be a very trivial reformat.

Thank you!

As you can tell, I got a little busy with teaching. I plan on spending
time with this tomorrow afternoon and a further revision should be on
its way then. Sorry for the delay!

Will

