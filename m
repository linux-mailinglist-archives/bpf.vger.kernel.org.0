Return-Path: <bpf+bounces-60414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7A0AD63A9
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 01:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A83B63AE7ED
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 23:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8822A25CC51;
	Wed, 11 Jun 2025 23:00:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF07246781
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 23:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682806; cv=none; b=hIxcBU/tnWEyZeAhxKrKFHqqKmmMInmMvPkJFx9+QcZVGq0DKujx/r8Zczm6cKVB9HnywbPSx+9F+XMB5Br6MsxJlc5k9VqNudkEtBhqBlDZJauF0o5tRC5mrqRt33uC/JdhDgL6VGQKRlx3pDMoIhvNdmlSZ+uKg7SOTcC2dNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682806; c=relaxed/simple;
	bh=Vf49EGmfjQiqZUocvGp+B+CNd2yii4KZkNjbexAHLYM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ArAyaHviWz3CDCg5ZP3h8huNBFDJqRaWMdXs1/3r1Sos94k6QkzML72KNFdW7ZSRYLggE24emyKrdDpaBYtGJg8qSRQNeOsQaNENMAgxbQjNjp7JrmAAJwpe9kc2BvxigffRIbEJtontZAf7jDHtjMKEAc5J8xKCEGrpcYGkH8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86d54e66cefso36034839f.1
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 16:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682804; x=1750287604;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vj0wabI4VIuyOapUUNmfqjGwRxtS9HaDBmLvM1X5Hc=;
        b=loGJF6k9zcJ9INwLvooQTBH37Gu3JNDpMzgRsTyW9EIzbF8wKdkZN3iBsIewYW7Zbc
         wGk/NkqkOGNLQVINTfN7NEt9hg/ccIrqvb/f+yA9AZDnFhLxC/JToyuzncaJJnTP0QJ7
         Qbs/ivjE9CjhM/1DtrDLyciie/ZDJDeVtq6Y5LSmPFcytqWvM8rfEsMGzCM4BBJt2syn
         PdoX7MyMsFSjNb0swil1ftKxKib+2KRo7jXgbOHsa17h2L8vPXv+iGqVLY8/bK5UnKyb
         8HQiyqpwMjLLepCi0sOd9ZlmVSUEnl2hjRbeTBSJQbKQNb74udl5luzeIlZaLT2NGV5g
         nmqw==
X-Forwarded-Encrypted: i=1; AJvYcCWweY4PhERC4tnbhvHG6guCVsK2CaqXv9hrSSzUxGr+k1gXxn9QEGLKN395toBtMerP48o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+iimaRJ9dO99Uj3mDgBUbq+PWo6NiXpS/h7maEf+ZgtYPtq/b
	INIfG16tQ3BWdO0tbrU4r6cscxd819kmxUQvhSsGPpGF4IiDUe8QWQrW35kN2gPKg1zMuTaeVBj
	e8qpIbiuZzl7uB1XPwc9lRV9Z9gPkpc8WLfnbRUDeUfu/5NLTPXqVQZpua78=
X-Google-Smtp-Source: AGHT+IHkU4buI3Au8WqU3EjLzuGOxFPtCqXnyADQDPoQih7sVqZJr+jEKYoGzubR+RLMPJCe8HWHbkqI4LrjGNgCKnUGOnLrpgHN
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1788:b0:3dd:d194:f72d with SMTP id
 e9e14a558f8ab-3ddf423f4bemr56878825ab.8.1749682803758; Wed, 11 Jun 2025
 16:00:03 -0700 (PDT)
Date: Wed, 11 Jun 2025 16:00:03 -0700
In-Reply-To: <26122837c64946d89cb5d0a3a568bdc2b4854ba6.camel@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684a0a73.050a0220.be214.0285.GAE@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: slab-use-after-free Read in do_check
From: syzbot <syzbot+b5eb72a560b8149a1885@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git@github.com:kernel-patches/bpf.git on com=
mit 974c296e39c3b2462bbf1f926d5a5db64399359f: failed to run ["git" "fetch" =
"--force" "--tags" "73aba3dff4d9ee1b85deaa6efdc44b9d57c62235" "974c296e39c3=
b2462bbf1f926d5a5db64399359f"]: exit status 128
Host key verification failed.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.



Tested on:

commit:         [unknown=20
git tree:       git@github.com:kernel-patches/bpf.git 974c296e39c3b2462bbf1=
f926d5a5db64399359f
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D76ed3656d7159e2=
7
dashboard link: https://syzkaller.appspot.com/bug?extid=3Db5eb72a560b8149a1=
885
compiler:      =20

Note: no patches were applied.

