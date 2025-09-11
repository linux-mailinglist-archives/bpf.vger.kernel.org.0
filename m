Return-Path: <bpf+bounces-68174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A0EB53A5E
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 19:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6525A4813
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 17:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077DD35FC29;
	Thu, 11 Sep 2025 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0Mr0ciZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86B7306492
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757611656; cv=none; b=TT/M/3nGfJrTeCf9l5LoaCNv+luFWfrGbARdPlReQ0fMCxrhqs7CNMw41R6Fax9neKlCGwyI273xrR5k5bLNGgbPtoDN6tqR9vKBMgqkTD1SQqGx3sWSDlfy158ZLgU+c0VTlj1/YBstkTn8yOx34+lWTolxS1in4PfsVqc+LEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757611656; c=relaxed/simple;
	bh=VCnfThcRdwutxJiLOY/PYtQP8buBVhfdxyh1018AQBs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=RX2m4GYcUdWNwbLPSYHmsA67jjHDYlAplWbamI2Dpy8lcP7wy+/Vo7rEkZc0WC5qQ9PcZYNKjaw9qEoe5ox1Ca6b4gCjEYy7NCjSvWtm8NNbRCr2uFaICfKK6JGi5cwTDYqTbEl4kZJBE99vn8UTcaomNfBhq/j3kP2I4Bnv7zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0Mr0ciZ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3df35a67434so704615f8f.3
        for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 10:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757611653; x=1758216453; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8RnVupEmD4w5VuJ70aQ0amLbEWI4RawjiEZPi1XIAlY=;
        b=J0Mr0ciZ3A+eBAXqu/oGJmYP+PULM9d6LS5xSUhuPFu5smZJoFE8nRFhJuRtfrYM0G
         MukqmabxyDoB+siHhiaJDaH8ruOx0b7fKoFDGCUHxC/sQfVbG9hc1jmrRu/5NH4+jAHJ
         3SaM2Tpag6Kikm4tj1ahGK8gN2dv1nesuvpUJhl7H+wpyRUxJKdsmmhM1TVi1aqFXPSB
         xrHSIGvI3YZU9N7MbdkWY/ZN1Egch78uGT7JzexsearYoy61IvZFUYAg19e2DwC6ucIF
         da2Lw03BJrDKwHgOoGTiYH/7+TmwFnuV/6t0vPylApy9biLvk+xTYPN3ZcsRJpkb5c7b
         V/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757611653; x=1758216453;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8RnVupEmD4w5VuJ70aQ0amLbEWI4RawjiEZPi1XIAlY=;
        b=LMlcHC3xCLdLjfHJy0G5DLo3wklPu4gLLVwkCxjpaLqCucrnax/ZK3a8Oz8xoyeVli
         z7kVhaLJjRkmFUB1KD1uwnAAOVdZXsAo4wD/ROp0N0zUmB+xrRukSXR38Gh+pv0C5Irt
         a9t2YrhgZVjPQZeKaYobentfk3C+A7yRzZoQvbmxbq3Xj04Or7Ktksi8Z4LxSWDuhDUX
         OcXTvU88sPE45A6P//fY5BaaMih36J6Vri+Z5jl0YUipQylgl7YkhhJoJe/IxmOT1Z1c
         hntcZoDwb7YGshLmk3eK678EQ7uC3eiWkB5ixI6Iy25D7SxhB9OCnysPNn7lVIZXLS5w
         RJDg==
X-Forwarded-Encrypted: i=1; AJvYcCVbhEeacpECE8GLcVAyHaRxd9KFZVw/Es0aO4bHp/xNWbVw8jlSsGibzSYED73KFVgAYpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjJEd6ZEG9bJoIfjpdc98tFljVmdeJ8f3LVtVRSlcVavgkFh+1
	SxDp1vMFjALZIoykDl2/5weIjoodbeRGHlPkH0Y3MztQt5az4PXuHxQy7XbOu/Hsq9Y+bUwIjcw
	8MQu1hgCQDUsc1P1IjzwKxcadlirc/Jw=
X-Gm-Gg: ASbGnctFkRwIx4C8JJ18XSrKbhiWHR+OgrRfBzlV6cTOhmsQnheY2u2k9zF/aoOtqYa
	aopusr1BkvLgUvteIEY9rt8mqQWKWWbNNDCA1lgDMJ16Svkb4mvzHvh0iYNuOVjFIgu3qjmo9P4
	TJciRNZDyUHFlsPTdZlFgLvH41Zowla4KqagltUcnzyNFO8sNOHCAwP8ywZZt2CTN7eYrsk6qWB
	yMiceNkM/RaCxOl6X6xLtk=
X-Google-Smtp-Source: AGHT+IFg/qdcPObe46qDm9hEx/myebmTXHgCeF0tDJ+whhAbx+ntXMchuwbDRrGe1C4x7eruB+QiGvxB9VwxvFVUlqU=
X-Received: by 2002:a05:6000:1a86:b0:3e7:490c:1b2 with SMTP id
 ffacd0b85a97d-3e7659c4d6dmr136003f8f.36.1757611653096; Thu, 11 Sep 2025
 10:27:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 11 Sep 2025 10:27:19 -0700
X-Gm-Features: AS18NWCwomWq12XFRL3YmS2wZlw5dem0tRg96ZLQ3_EmIVvTViPp4lX97DD3s5A
Message-ID: <CAADnVQLcMi5YQhZKsU4z3S2uVUAGu_62C33G2Zx_ruG3uXa-Ug@mail.gmail.com>
Subject: bpftool uses wrong order of tracefs search
To: Quentin Monnet <qmo@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

Hi Quentin,

since last merge window bpftool triggers a warn:
$ bpftool prog tracelog
[   72.942082] NOTICE: Automounting of tracing to debugfs is
deprecated and will be removed in 2030


I suspect it happens because get_tracefs_pipe()
accesses debug/tracing first which causes automnount
and triggers this warning.

Pls take a look.

