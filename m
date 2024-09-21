Return-Path: <bpf+bounces-40165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8EC97DE59
	for <lists+bpf@lfdr.de>; Sat, 21 Sep 2024 20:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46AC6281A15
	for <lists+bpf@lfdr.de>; Sat, 21 Sep 2024 18:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA433BB48;
	Sat, 21 Sep 2024 18:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OUHdOYRk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC462A1C5
	for <bpf@vger.kernel.org>; Sat, 21 Sep 2024 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726944089; cv=none; b=QqjpU2sNI05U3cRPHfeBbOwBUyAdWlK+9c3q37lUySTLeXr5s/hudnj8fVQvee/F2Ucnf6wiYopR3Wk9oIxdbbFHwhWX3stz4N5qPPimT7PaJAxaRN4oPCkprYaKG585MWfMj5/l3V5CRdb0zKRTBS5U4T5jt2ajqEQB/A6I+yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726944089; c=relaxed/simple;
	bh=aorzn1QEglKg3ZGv5uHXFQumitlu9sjO6Dkma9A9IGE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PnTOwloLJCLfuUsH/fcZ+q7xcYjeNFVMonHnvJCJEbpumkZZyAEzwjompYBQTLxLDtsKaP21kh/G1LFZBsoHuPSHOG5Rg2/uORrB6YaPGH71AYPyAa18Ub2t03sBKLxc7QN0dPG81LiU4jo9z+M9sd9ng/XmmdQlQCWpAbqJTBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OUHdOYRk; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-374c7d14191so2464576f8f.0
        for <bpf@vger.kernel.org>; Sat, 21 Sep 2024 11:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726944084; x=1727548884; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KbLTtRg0Q/BL3MtZK6Y3T4inyODSiXmZIM97Q0TIFZU=;
        b=OUHdOYRkycO+JUaeaUhkCNgH5mtFGKYXPpA4aI8pxc5OyhdG+L0IQJmZi34MPJq1rM
         tzH8RuOul5fVJP/1BKbHw6rjAVx+cP2kI/6dAO/AUFjzlzb35U6n94wtaMZm4wNXDYJw
         87Sclm+fAgdkjSQmryeGVhd+Vn6v9u27ckQPXGGnl6VkrjZkHS9g3DdCtSlkwhnvTuoB
         9Y6QIxb21bv0SvNTD/Lf66S550CzxU5cVAxSoSuALgprvzqnYj2Pm2Ix9vlCJrtPuryc
         fE6YTnBfx40v7Ly21xlujFcBflWLDpdJiPABSUj4iC50UEzDUJiw/E3seqbbBLeGuPez
         XBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726944084; x=1727548884;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KbLTtRg0Q/BL3MtZK6Y3T4inyODSiXmZIM97Q0TIFZU=;
        b=aKpvHX7rz4YRyBFh/6zI/Yx1zB1ynyPpdpnczUwV3Zs9Hamkvbv3+aR+IzmMgU6Dpb
         8VRcY50Mn+8EmpK2CMWtwXpqHv1t3L171UqxhKW0Sh/1bQa6Iz0+k49t+aK8esFbAgpr
         zngTvS4pPYkbRe9gzVt9orMBYsN2FZ2u906E3bbHEA5HcnrHKn4Jn5BttrtaOTAUm3SO
         Olxu7Uu3+7T4MDkB1DwGMH2cwku7AG5wiQJc0qTpO+ejLFOt2hGsfCqqdwzOGimV7hNz
         eQJ7UrZBFDZ5naEUU9pHe3sBWHiFUndi8/BDqcD2+7Eh9FzDAGCpkCxHauvc/wPmjnAK
         ZbnQ==
X-Gm-Message-State: AOJu0YzmH3FkwDr7okFoHa8FqoKjsR/0TWydylFl9ehF/g9WcAug5kYN
	iVIITzX3uaVU9lLBqO3Tf6le6JdyVS8vnvsG9wva/TOjOrmnuBblsrd8+CTYk68P9iz++FfowSK
	jHIV8wZd7
X-Google-Smtp-Source: AGHT+IHZlN9SkcbNY1VM7bEXp6y3Mihd9WudpfgD6rBMVa8LpDXhSbBZzi+zvVDh49zV4KClYOHQTw==
X-Received: by 2002:a5d:59a3:0:b0:376:e2f4:5414 with SMTP id ffacd0b85a97d-3799a1c51b6mr8454812f8f.5.1726944083878;
        Sat, 21 Sep 2024 11:41:23 -0700 (PDT)
Received: from u94a ([205.220.129.241])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acb08dc068sm312185085a.125.2024.09.21.11.41.17
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 11:41:22 -0700 (PDT)
Date: Sun, 22 Sep 2024 02:41:08 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Subject: Good first-time BPF tasks
Message-ID: <3xru56ozvb4mrphuqt53tvbsiv3n3wfcknme663zcxefayx3re@oq5xnb3o3fec>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A topic that came up several times off-list at LPC was how to start
contributing to the BPF subsystem. One of the thing that would probably help
is to have a list of todos that are nice to have and can be implemented in a
relatively self-contained set of patches. Here's things that I've gathered.

On the more concrete task sides (easy to hard):

- Check return value of btf__align_of() in btf_dump_emit_struct_def()
- Replace open-coded & PTR_MAYBE_NULL checks with type_may_be_null()
- Implement tnum_scast(), and use that to simply var_off induction in
  coerce_reg_to_size_sx()
- Better error message when BTF generation failed, or at least fail earlier
- Refactor to use list_head to create a linked-list of bpf_verifier_state
  instead of using bpf_verifier_state_list

On the more general side of things:

- Improve the documentation
  - add the missing pieces (e.g. document all BPF_PROG_TYPE_*)
  - update the out-date part (admittedly quite hard)
- Improve the BPF selftests coverage
  - add test for fixes that have been merged but does not come with a
    corresponding test case to prevent regression

I want to keep the list from being too verbose, so I won't go into too
much detail in this email. But feel free to reply to this thread and
ask. You might want to use https://github.com/sjp38/hackermail to reply
if you're not familiar with mailing lists.
(I know mailing list don't have the best UX, is a scary place, and also
not the best issue tracker, we'll see how this works out and change if
needed)

Also If anyone has other things they want to add to the list that will
be great.

The most probably outcome is nobody replies, and I stop doing this after
a few months. But still, worth a try and the only thing that gets hurt
in this process is my ego ;)

---

Expectations

  You should have a relatively solid idea about C (pointers, memory
  layout, undefined behavior, etc.). That is not to say you cannot make
  any mistake (we all do), just that mailing list is not the best place
  to receive an entire lecture on C.

  Personally I would also recommend to familiar yourself on open source
  contribution, elsewhere first.

  You will be doing 99% of the work and have to spend a great deal of
  time reading code to try understand how things works before you can
  write you first line of code, and at that point you're probably only
  10% done.

Disclaimer

  Maintainers have the final say on whether things gets merged or not.
  And Sometimes things that seems like a good idea at first may turnout
  to be undesired; so there's no guarantee that all the hard work you
  poured in will land. Additionally the task may turned out to have
  hidden complexity, making it a not so good first time task, but only
  to be know afterwards.

Resources

- Introduction to BPF selftests
  https://lore.kernel.org/bpf/62b54401510477eebdb6e1272ba4308ee121c215.camel@gmail.com/

