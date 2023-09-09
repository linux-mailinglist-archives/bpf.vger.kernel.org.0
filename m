Return-Path: <bpf+bounces-9603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942C879996F
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 18:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78DA51C208CF
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 16:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEEE746A;
	Sat,  9 Sep 2023 16:12:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C9C6FBD
	for <bpf@vger.kernel.org>; Sat,  9 Sep 2023 16:12:38 +0000 (UTC)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F4E197
	for <bpf@vger.kernel.org>; Sat,  9 Sep 2023 09:12:37 -0700 (PDT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-570a1c83727so3566956a12.1
        for <bpf@vger.kernel.org>; Sat, 09 Sep 2023 09:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694275957; x=1694880757;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v7nzmSUstAY9iXOgzx0SrvI4KAmIBqP4eruzpfGoWhE=;
        b=xDkhgvpqXKp7SLdxbmo7WzW0T0p0LJs0ReKbo4Ad/zBf4V6aQVDGp2oyX3zt2A/Apb
         2LOqMtGARaJCcWetlTrabLFq1PDWZiw63wEOcnGRZGYaEOzAK+VlKGTDh5Sj7soF+1BC
         R8hbeW1OBZJcqTOFKrScyLTH5T7LkjzWVO2eiql6ml20q/+kY1tJoU3YLjL1xhH7OH1N
         aky3LGS6zs8lZmcRag6BBdaqQfqZJfH9bFxcxHHHVrMSPuCG0YdUaksW3sF/wfFSGJQ4
         uVny8LVyS6HdFndmZV981iJER0JkJco19B/Wsx4+zr+PvhCuHDO5oRR5HeE+6W5xOChE
         CKJg==
X-Gm-Message-State: AOJu0YxLANZK3FoWehlytlRjABsVU8o0tDL/t/mlxBMlz6CBEjF8UM9/
	Hl6weOw+ej2Rp/leQ1wc8UcJvrLdJeM/mFGym8M/76as18/H
X-Google-Smtp-Source: AGHT+IHB8tpqCVGsHysIYhKGMTC17bOoeqx6WIvtbuoYab8f/mFbkUgNQ45UMC/BR6WY4zyp3FT6rrxnhxirCoPnI1MWOUk84NMq
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a63:2742:0:b0:577:460c:1d1f with SMTP id
 n63-20020a632742000000b00577460c1d1fmr392879pgn.7.1694275957183; Sat, 09 Sep
 2023 09:12:37 -0700 (PDT)
Date: Sat, 09 Sep 2023 09:12:37 -0700
In-Reply-To: <000000000000d97f3c060479c4f8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000945b5b0604ef5cb6@google.com>
Subject: Re: [syzbot] [bpf?] general protection fault in bpf_prog_offload_verifier_prep
From: syzbot <syzbot+291100dcb32190ec02a8@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	haoluo@google.com, hawk@kernel.org, horms@kernel.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, lmb@isovalent.com, 
	martin.lau@linux.dev, netdev@vger.kernel.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yhs@fb.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot has bisected this issue to:

commit 47a71c1f9af0a334c9dfa97633c41de4feda4287
Author: Andrii Nakryiko <andrii@kernel.org>
Date:   Thu Apr 6 23:41:58 2023 +0000

    bpf: Add log_true_size output field to return necessary log buffer size

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=132a4268680000
start commit:   fa09bc40b21a igb: disable virtualization features on 82580
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10aa4268680000
console output: https://syzkaller.appspot.com/x/log.txt?x=172a4268680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=634e05b4025da9da
dashboard link: https://syzkaller.appspot.com/bug?extid=291100dcb32190ec02a8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1529c448680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15db0248680000

Reported-by: syzbot+291100dcb32190ec02a8@syzkaller.appspotmail.com
Fixes: 47a71c1f9af0 ("bpf: Add log_true_size output field to return necessary log buffer size")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

