Return-Path: <bpf+bounces-5707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D554075EECD
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 11:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9039F2814BF
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 09:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676EA6FB8;
	Mon, 24 Jul 2023 09:13:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3349346BD
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 09:13:34 +0000 (UTC)
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D581A5
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 02:13:33 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a5ad0720d4so3244087b6e.3
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 02:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690190013; x=1690794813;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/68D1NVpjDgOAkUJuDYSp1QYtQNfm/oepylLJakZ8SU=;
        b=f/JohWEl8Ux3PjMjS2zQXWQOrYlEb9WjRvXQvzdOI8Cj3rbKOFQz8PjWHFJNkRI4wi
         fiH0UMMADtX0xxPtNn4Cz7DWrmgypT/+oyGXqKuHPIkrhbJBile48tXeUp+x3crHJ1UI
         78v8WUyp6A6VBq5lkp0Xx7HwHIlqTHkkLl1Uk4h2oN6LvJwdekCeH0kMUKnAVPeqio/I
         kep3Xw6DlpgevNEmPMclMJJJ2ExRg30yt1WfQ2fDpsZG13fMOhXciNmSQctCkbWZ9/aC
         9s/L8ZDYSspQSSaWoXWiRYrP3X8hmHqQoMuxnLX7DIsWWSpqQFxuH8653zqC4QyyQjHA
         iovw==
X-Gm-Message-State: ABy/qLZtimhgp3pIil57R+zfsuedLon59CdqFMdk/+gzvXttCc7JwYKo
	EaZ/QimcQTx7XJfm/jb85D32HBuMRdy7HCTYGetJTJuvARJF
X-Google-Smtp-Source: APBJJlHhD8j3WMGPNMRwhpIQ5NfH51cbt05RHMwLUgVKLR4yT+Dh2yKRweGEy5zHCaM+S65ljUXdhQZ5Tp4e5akajof/P+lWkeSd
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:ecc:b0:3a4:87eb:da2c with SMTP id
 q12-20020a0568080ecc00b003a487ebda2cmr17689590oiv.0.1690190013150; Mon, 24
 Jul 2023 02:13:33 -0700 (PDT)
Date: Mon, 24 Jul 2023 02:13:33 -0700
In-Reply-To: <000000000000ee69e80600ec7cc7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000563cff06013807a0@google.com>
Subject: Re: [syzbot] [bpf?] WARNING: ODEBUG bug in tcx_uninstall
From: syzbot <syzbot+14736e249bce46091c18@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, haoluo@google.com, hdanton@sina.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot has bisected this issue to:

commit e420bed025071a623d2720a92bc2245c84757ecb
Author: Daniel Borkmann <daniel@iogearbox.net>
Date:   Wed Jul 19 14:08:52 2023 +0000

    bpf: Add fd-based tcx multi-prog infra with link support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14c60c6aa80000
start commit:   03b123debcbc tcp: tcp_enter_quickack_mode() should be static
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16c60c6aa80000
console output: https://syzkaller.appspot.com/x/log.txt?x=12c60c6aa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=32e3dcc11fd0d297
dashboard link: https://syzkaller.appspot.com/bug?extid=14736e249bce46091c18
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133f36c6a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a8e73aa80000

Reported-by: syzbot+14736e249bce46091c18@syzkaller.appspotmail.com
Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

