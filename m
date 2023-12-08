Return-Path: <bpf+bounces-17091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2516E80997A
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 03:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12DC1F21340
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 02:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BDA1C17;
	Fri,  8 Dec 2023 02:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yxv3/Wfu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8960C171D
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 18:45:18 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54d048550dfso2296232a12.0
        for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 18:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702003517; x=1702608317; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eosqYO9c9lUc0pt0nKQ7R89AmgSLiz6lh/aDCUvYEa8=;
        b=Yxv3/WfuT3WxbSJGSkMihBb2fO5sbYgeup8z3Nl0u2PKXO28oGUOHUnfvrtiZvg8bV
         54EqH5B5LtV+IL+aZUA9bPTgdA06Se2NZyjZs7lUmqpxTgTyFPv9hoZxcQ8WZh0ahlr4
         6APITf93o7oRoD6D7yPgzpPY+MD+Z/rLOqz2TtxuHXmn1+x9Z9Dczc+7Uws7VMqsmpgA
         i6W/b3kE4ZLIJLtY1goHXpMyjpjB67l0QI6005Z9mS2cxZiShV3XYzbjvjYxAZ0B31Ke
         To0JRehOQ7Rtxw/mjLFpUwqQn2uQ5v2ytwpc4wUI4I2KqzktMeSeuAx662SmBgioL6zQ
         QwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702003517; x=1702608317;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eosqYO9c9lUc0pt0nKQ7R89AmgSLiz6lh/aDCUvYEa8=;
        b=p825t6Uxc0PCPgFaLYoCqCuuJjT+g32lHn9egDE50ptYrPWpymcU9wOEBISlwuL4e7
         Yw+PUCySgX6rc8ypt9gTtPltkG8A3RShJ3Lml1tprmj0GS7NP9YkBg65GoXAWGOSTgik
         Gxb5ca1hMH3vOyceefEwkBpCVA+Pda3a+bFlb769lZHik9QshNgsxti5T1K2k+zlrD/f
         N+Wvjz3FRIPSu/DC91J0JuHJ+y1J+OHJoOh89AlRyD0JznaUoD4wV7Dd+2X+4RZj7N4I
         obKyDp7lodIY4LbpEgLm8IZqWuU0dsbx+IhT8nZILeljxaU3XBseLhwmBgog30tq7Kcj
         Nr6Q==
X-Gm-Message-State: AOJu0YyJhduJlTqvpsnCZnFDFBX4ypg/2Cr7jTTE5hZMVMzuRcV9CYY6
	tyKQBg8ezHfxXdWsCWphFtuKMZMCT2vWiJSFIKf/CFrlyNg1LA==
X-Google-Smtp-Source: AGHT+IGpNIZdEVxqaJMebHSLw4BfXNmv3aRwVXNcV/dyf6CinHb/2OmMrrgHrnq34SX0CRK5rLC5uJQ4KKTwp3drBOk=
X-Received: by 2002:a17:906:5fd2:b0:a19:a19b:4273 with SMTP id
 k18-20020a1709065fd200b00a19a19b4273mr1633032ejv.222.1702003516416; Thu, 07
 Dec 2023 18:45:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208023150.254207-1-andreimatei1@gmail.com>
In-Reply-To: <20231208023150.254207-1-andreimatei1@gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Thu, 7 Dec 2023 21:45:04 -0500
Message-ID: <CABWLsev1q+ves60giYt7rFU--yfhCjgchyoduttgZa8mjynEeQ@mail.gmail.com>
Subject: Re: [PATCH bpf v4 0/3] bpf: fix accesses to uninit stack slots
To: bpf@vger.kernel.org
Cc: sunhao.th@gmail.com, andrii.nakryiko@gmail.com, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"

[...]

Some decorum questions from a newbie:

I'm not sure if this should go to bpf or bpf-next (or perhaps if only the 2nd
patch here should go to bpf and the rest to bpf-next). If anyone has opinions,
I'm happy to re-send or to let whoever applies the patches to choose at
application time. Patch 2 contains a couple of fixes, and there was talk of
backporting... although I'm not sure how bad the bug(s) were in practice.
Patches 1 and 3 don't fix anything, but I'm not sure if it's worth sending them
separately. The first patch doesn't apply cleanly to bpf-next because some
fields were reordered there, but it should be trivial to fixup.

Btw, I also don't know how backporting works, so if I should do anything about
it, please let me know.

The main patch (patch 2) adds some new testing conditions to some existing
tests, and also technically adds a new test (but it's really a subset of an
existing test; the comments there explain). I know that we like to generally
split tests to separate patches (for reasons I'm not sure about), but I don't
know how far to take that rule; not sure if I should apply it here. Will take
guidance.

Thanks!

