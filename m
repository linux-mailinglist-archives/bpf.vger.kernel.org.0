Return-Path: <bpf+bounces-40180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2DC97E317
	for <lists+bpf@lfdr.de>; Sun, 22 Sep 2024 21:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49C651F211EF
	for <lists+bpf@lfdr.de>; Sun, 22 Sep 2024 19:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4474F4D8C3;
	Sun, 22 Sep 2024 19:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TplQuFde"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B5863C
	for <bpf@vger.kernel.org>; Sun, 22 Sep 2024 19:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727035171; cv=none; b=FE/Sx6SJzvarpHOMNWU/h3TFdvgOVCagsXDMkjRZLYxX/9VA4N537Y6tRnFe3+6kdtKy7fCFeWxxP97rSVznvrQCVLmxBQGIxTXMvuRhHcg8uRsTE6iBD8VFPvAAbCspCO4b5NxFhrKOhl6HNIjDP9I2J0vQvwo9AdGRkXJrA/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727035171; c=relaxed/simple;
	bh=VOFCkAGXgfZOymYOV8ONKcj53QpWXkbU0vBxM3rSAnc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=cfdIdVXxRya4weMspr4QKnujBGC33yY4VhbNVegfKAYU+38HTkSzzmDMTbJFZQqfzTlM538VNJ4g6xaANLpr/+C8ZOxhN/8tRT353T9kTO25RO1UeLqBeE52yyGwBVifDdUskOru66wu+27ahVghj2z+3G00Ogh6+WMW2yGDZ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TplQuFde; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d889207d1aso2367124a91.3
        for <bpf@vger.kernel.org>; Sun, 22 Sep 2024 12:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727035169; x=1727639969; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VOFCkAGXgfZOymYOV8ONKcj53QpWXkbU0vBxM3rSAnc=;
        b=TplQuFdekAiEHYWy1RDbsFp7f391Wx/7btk/g6KlYWhiGF1ekKNv/ABARVJrhrRzAJ
         14YxBaKjrwScen+2rDoEZb5owdSTJWCv3XGAyRo2OPtMbzbkK9u3mxh7IreD2RzCLUFD
         wk+3S09AT4sEGw74o4OK7U0+5eiA+7wUWY2rt4ZyPizAi7a5KouYHIL0U3MOYWWJLT6J
         Dn45wCRxBFl/1nzx3T+DyWYSV6MxCYCHSUPe1d1RGJyd1MtXRyNSEhBpgKrZw2vuNtUN
         D8TSJQVzYJ9I3BF+B4NgB8gHr/QJV04HpSQOdOq6CrRoADycK5Y6WBg7QugHl/a8k7Op
         4o9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727035169; x=1727639969;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VOFCkAGXgfZOymYOV8ONKcj53QpWXkbU0vBxM3rSAnc=;
        b=oqU7sgsozbpNcyxZT3aDt2SgIVR1tSXLxIbcl2dpSzRGA9zJZiXvyPCJvrqkkrWQz3
         h3Rpj9OE5Cs5E7zlhU8Ym4sc4rXFxYrbuOeogRKEGgS0T7KXQme34eHGkeT7jfO7wgPp
         Gb0g3CDxG7z8yKnR6QdUOYk+eZRCKSz9/ZkVObo3qCUmrnAP/IlQwDxZT8xKJpjzWOkD
         7abxbMsTSjsDDWuS99V0xhWW7yFr3oUvTU6guDZ/rAxPCJ48MVbMmyl7F2b7q2U2Mt7S
         LYpXbuU9zRr9fY/wKxzLJT6MDMk2mzVWwqBI+JMj0nUebgDpQT8vP0wWXYU77STCGM/Z
         E0ZA==
X-Gm-Message-State: AOJu0YyaHHbntsmkTqUyLbS82GyxnOfGE2A2geYxJKLF+t2jzkJRcUzS
	27nYRRIR/yfy6K1hjedU9gujKiWpuxlTuVkpRt1uEMYfGdD4p+zKAPXn8eC66l6fR3cjU2jhGxK
	1N6moTxxqEDx7z82CviiJ6ChsCjVf6UUvHZA=
X-Google-Smtp-Source: AGHT+IG/V+YpmBKaCKz4omq9UZMrrw9tIP8Y34+Uik4a7fjlL32OR15Hn28rW1OmrX62EjwHWIWMcXvq8I/I1VdKKKI=
X-Received: by 2002:a17:90a:62c7:b0:2da:9490:900c with SMTP id
 98e67ed59e1d1-2dd80c7ecbcmr10735278a91.21.1727035169522; Sun, 22 Sep 2024
 12:59:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tyrone Wu <wudevelops@gmail.com>
Date: Sun, 22 Sep 2024 15:59:19 -0400
Message-ID: <CABVU1kWEHkt+z1c0vu1bXMn81iY8rDjwU=B6KPi2dPVvgeZUPw@mail.gmail.com>
Subject: bpf_link_info: perf_event link info name_len field returning zero
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

When retrieving bpf_link_info.perf_event kprobe/uprobe/tracepoint
data, I noticed that the name_len field always returns 0. After some
digging, I see that name_len is never actually populated, which
explains the 0 value.

I expected it to function similarly to
bpf_link_info.raw_tracepoint.tp_name_len, where that field is filled
with the length of tp_name. However, I noticed that the selftest
explicitly asserts that name_len should be 0. I was wondering if
someone could clarify whether it is intended for the
bpf_link_info.perf_event name_len field to not be populated.

I apologize if this is not the appropriate place to ask this question.
Thank you for your time!

