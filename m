Return-Path: <bpf+bounces-58314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0106AB8759
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 15:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785A34A5F67
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 13:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CF529899E;
	Thu, 15 May 2025 13:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wne7+JIf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4E71BC4E
	for <bpf@vger.kernel.org>; Thu, 15 May 2025 13:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314565; cv=none; b=B4+Sez3g2EB9JBVcQa7lzwQpuqWDLC6Xs8rfuTzkmkFpCQ49pBAQ60ujEDo9l2Je16axsxJEy5UJp0Z0NDOG5HRCZbQAlJN8C+m/LdxzBlWedWReMcyfbWTANtOaDCp/YumNOW9UgBPmZ44OinSvu+90FS7+gEQZ7L0uQIvvRAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314565; c=relaxed/simple;
	bh=cGjU5RITXe5bpC778S2pYs7tHW+b+SQyg06kNXMVcNQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JdXaoV9OQjaCV6Anps06kgCS1s+VS17/KdRUkz/NpBEfLRyRI1jYlJcskDM2nBWekynNX3WG47/uCxUrhfZyhUy57RdoxXixlLNPIOCU+FeuRurzSg7orWO2pUeXxJvzNRl4uWU9ROEaiF4ozESSZPwig4QoU8Nnfj4pZtdBQzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wne7+JIf; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6f0c30a1ca3so9259296d6.1
        for <bpf@vger.kernel.org>; Thu, 15 May 2025 06:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314563; x=1747919363; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MTxbQSf6tTz86Tpzv5hXxXYTrQ8Reqx/kwDF3QCElqo=;
        b=Wne7+JIfFzo6wtQgLViCD2werLATGI0rph+/oPqOcfmTb1WxF3A4ROg+KVbkDrI5rp
         SvUmfSFuQZtzntrgBzM5+uV6wmDxx5VRnHNWLd4Qf2xraWHqEOUcXLXTLYsW5V30mnva
         Z6rZBFIFB/iT4m8DuOoJsNXnFqUSbZoVw7t44MXiXBeDLoAV7Z2js8nMjB2K86VBl2qG
         WB+tc7PPtgv6tmKoowO8hpZLe2KXpVDV+fmHCQU7hq/PopzViBSUOmC+/ywdtNrNwYup
         LTctOHM9X/Wmhlk+YXyMN3iebLv9AoIbsWmaxAL3DjRMPbqME4L6Ntd+1viXDdfSmYaF
         sNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314563; x=1747919363;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MTxbQSf6tTz86Tpzv5hXxXYTrQ8Reqx/kwDF3QCElqo=;
        b=o7Z5Jfv9P35vJdedjHIki/lQUFRJAQf+lCQkppHhPDAkhatGuYS0w7t8DBlSyQ89PR
         t7q1pzYxyJDdNydSNiaL4Ywiu6zFeroWn1kcU1TYdmy3gk04ug3pimp8cVKHh+sYVCS0
         dWar8KOZ7b4NRK4tDzb6hejdyIqD1jqkWCZvXZ8W+L8vmr5hhNrfDMjk/wM44/TA3mfS
         jq0zF/i7dKiEdvOvDTugW/GpjqHKFs68h+GAjuRGJKqMzhvXdJUmvYfLihb8SBf1eSfQ
         CtpiGZEh5QuS5U6kEOVRFdXHDc4KjLBFNsUSm1IbraRBep1Vn6t1+35MPZlun3NxcI1R
         daNQ==
X-Gm-Message-State: AOJu0Ywc4zdSDVatvinoJUDmk0ZoAWyf68chs0ZfU6Yg/6rNdkTAH93C
	givEiqu3XrA+5hX+nkXDYtfxkL7KQq+BIIC7QAdOtgPe9uJUbCJWxNrW7fNk4b4y6otyAkzYSDu
	DEnDn1AmUd1N4KJzwztqSOc54MrsVRiRw
X-Gm-Gg: ASbGncvDQYX9Tux+pVZH+KyGWebbvA1/A7rXJ9acjJYaiLWw9QAAYbhn2SCa9o0QF6j
	y7RURbKtIrl+MMWNj/pIKkO6lf0G8ueCPgIgtHJs0WIWJtiezMSDaPXToE3e1M93MJho242OLKZ
	TRyiyYZCc/95X3PK6+Z6OghjJFAorFh3m9
X-Google-Smtp-Source: AGHT+IGeMzYVKBfV8+TYDz6PqxJgUPu+pyAJL46gIAw0ubZ+MAPazN5Fp+Nrn2c7/Q5ILDwR1F73N0dP/49uJlKEThU=
X-Received: by 2002:a05:6214:e69:b0:6e8:97f6:3229 with SMTP id
 6a1803df08f44-6f896e0e90fmr135513826d6.16.1747314562467; Thu, 15 May 2025
 06:09:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Thu, 15 May 2025 06:09:10 -0700
X-Gm-Features: AX0GCFsToV2maMVE75bI65zrILYq0vCV_MPjmr1xb2PRKsPHbv62aoPqOU_5kHU
Message-ID: <CAK3+h2yAtw6GVLEzGePkJ+3vPy5ZrKKnJjsXqt0sZO2xfW8u2Q@mail.gmail.com>
Subject: [BUG?] xdp-loader unable to load XDP program with bpf_xdp_adjust_meta()
 call
To: bpf <bpf@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

We have run into issue reported in [0] when the XDP program has calls like:

bpf_xdp_adjust_meta(ctx, -(int)sizeof(struct meta_data))
or
bpf_xdp_adjust_tail(ctx, -1) < 0

xdp-loader is unable to load these XDP programs with verifier error
message "Extension program changes packet data, while original does
not", it seems to be triggered by the patches [1], removing these
calls work around the issue. it appears  another workaround is to
bpf_xdp_adjust_meta(ctx, 0) after reading [1] thread?

[0]: https://github.com/xdp-project/xdp-tools/issues/503
[1]: https://lore.kernel.org/all/20241210041100.1898468-1-eddyz87@gmail.com/

Vincent

Thanks!

