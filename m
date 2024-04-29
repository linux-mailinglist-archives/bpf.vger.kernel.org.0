Return-Path: <bpf+bounces-28210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CB38B663A
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 01:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA111C21490
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CB51836D1;
	Mon, 29 Apr 2024 23:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h91cri4t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1237617BCA
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 23:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714433373; cv=none; b=CTpVUoz+RqBDvbQQFGKNBoRjhlRF4eGlDgjSN1D7kgiza9ama3nLjIlWVtg2EyVBmsH6/TRJFKaS8OyJ+B30Qri8O7rwr4baf5D/9SWVBZBtrWsiXuhRZrp0t/ZMAdkNeQVEgGWQlMec1f44hpyfkD0R2jUP5+uSwXASbi+p0WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714433373; c=relaxed/simple;
	bh=qXWUQkel7tZvE0bdHFz7udj9Ssh0vjqklajMxlPD3/Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FeAaRYnh+fKdVbtZzHiOhpRiKB+m8OGGTXLn7bn/2k6hsO7MMZIHo6US/D4vvfrkrsgGx6PJ9b1KvjThg9n6GqVYbygZL6pVMIWoSMHdEFaDC1lNDebP7hqtW1zRipDtBdbzkFYJlhvJPbYwtSBlFE3VfuwYMvMc9q1c9zZ6FMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h91cri4t; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so34578375ad.0
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 16:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714433371; x=1715038171; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qXWUQkel7tZvE0bdHFz7udj9Ssh0vjqklajMxlPD3/Y=;
        b=h91cri4tjtzRzvNAO0wVEx6sqfuEiZ9TV6b/cnqnHI8HVIgjOHy46ZIAnweZj2U5a/
         9f20tUT6DVdKkUM7wHO/IqUX0yRKohxmnXP8lpNlGtAkLviCbzq/hqUn8EhtMhVSpc6/
         Vmig72N63C2HoT5ttHBw/FxeFO1nDxW3UzVfE3Xv2Ze+j6PB2l9uHrRBx9JJKk7Nv5OQ
         pjptZP1jLf0BCKCDbvuJFnRSnjT8by8N+bdwlgAlgO0AWE1TsAZJOIBcEufMvYYy+sIm
         LlCy0ioF1lgddTRwORatwTapWAbK1ZN/tuyxXu09bFJ8ms53gcU+QO4lN6KLQx5W4ZOT
         MDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714433371; x=1715038171;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qXWUQkel7tZvE0bdHFz7udj9Ssh0vjqklajMxlPD3/Y=;
        b=EjgB6OsHkKQLId35ftZO42nXt79/G8kGl8TRS0U6jejmgoVFlPxgfuUAh8ReYMM6Ul
         OBTn+gaumki0eWwbb266eH3EYKRZt5Wck0CIoaF//aqzLgylJMf1TMXIeRVpyvFt4HAQ
         9U5yajWqaX2znkD/2LHwy4L7c2F1bEOTVDf6nFMAqA4a3lVqb18z/7N088FC8Huwm11W
         oJFV77v8a0K0f5Y5T56DodQAXGLRQOR/Dd+IjzU0t2ue+iDYHf/dXbOHNsiBKQQ6hwdE
         lVR+IKx1I1u2HR/naRMOnCWo0BMC5n9wC//5KoermyKLHE5tuZDkeiVeLOy9tyu9HmCx
         uqOg==
X-Forwarded-Encrypted: i=1; AJvYcCWxuyuLqKO2Tf3wEs7Dd+9pVpESck3SOqDeRxGV4JMgCrSQ4iauPnRBULv4DKQYqFWOpF4tV5L1q4xx3YntYnerPtm8
X-Gm-Message-State: AOJu0Yy/qqAYTEK5NrCt2lh4BNlWlONlZN6smWRtLkYUiVIf4QsuTEW2
	Sns0dkdLHfTtUHJkz4q0RL9SKah0WBF98sXD1plSTWDKzyFj/Sp0UtXpascS
X-Google-Smtp-Source: AGHT+IFO7O1Cnof3JWT3O+GsGHvHEXp2LyY03KHL0R7W3DuDPqFSome3js8jklzuFOAAUShd+G0BPQ==
X-Received: by 2002:a17:903:228c:b0:1eb:7162:82c7 with SMTP id b12-20020a170903228c00b001eb716282c7mr1469356plh.18.1714433371235;
        Mon, 29 Apr 2024 16:29:31 -0700 (PDT)
Received: from ?IPv6:2604:3d08:9880:5900:a18e:a67:fdb6:1a18? ([2604:3d08:9880:5900:a18e:a67:fdb6:1a18])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902784200b001e797d4b8acsm21398417pln.174.2024.04.29.16.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 16:29:30 -0700 (PDT)
Message-ID: <c1d17ea3c74e7cec4ba2457e2d6b88d324064af9.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 7/7] bpf/verifier: improve code after range
 computation recent changes.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, David Faust <david.faust@oracle.com>, Jose
 Marchesi <jose.marchesi@oracle.com>, Elena Zannoni
 <elena.zannoni@oracle.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Apr 2024 16:29:29 -0700
In-Reply-To: <e0aa743fd6044691d0b30e7b2761c8085a28bb0b.camel@gmail.com>
References: <20240429212250.78420-1-cupertino.miranda@oracle.com>
	 <20240429212250.78420-8-cupertino.miranda@oracle.com>
	 <e0aa743fd6044691d0b30e7b2761c8085a28bb0b.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-29 at 16:16 -0700, Eduard Zingerman wrote:
[...]

> Still, I'm not sure if we want to remove this safety check.

... and if we are going to remove the safety check,
then at-least there should be a warning like there was before the
commit from 2018. Which is almost the same amount of code as current
'check + invalid flag'.

