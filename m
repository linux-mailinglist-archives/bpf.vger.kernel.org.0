Return-Path: <bpf+bounces-276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB796FD7CA
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 09:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EAF7281332
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 07:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F673569D;
	Wed, 10 May 2023 07:04:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDE4814
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 07:04:57 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EDE46B7
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 00:04:56 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-331a812aa1eso43769595ab.3
        for <bpf@vger.kernel.org>; Wed, 10 May 2023 00:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683702296; x=1686294296;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WK0wXV6R1uiBGG4s3BCaLAxA6ayNf4jKU69VadTOhBA=;
        b=Slq2YDzkqfausDBjncwnN8T9O4elcS+483zJmiisWao65mTTQgrWiHWKtctCYS8PCz
         y29FePMeH6XObkHW6D0nryAXCyuWvhAQzIazQcprs9+E4axuUL6OUT9dikvgO0PEHLOc
         s589ZvMp9D7AY4dYdxEvCiGH1CWObU37ZpPCI/tr20eSD1Vh4BO5YWEGP6CkewXbIHas
         LAT1q9FNe3ZhaUdTqAbP9GVxmwNWg2SrLK3BjCESDbVjo5uf5EGTK3FbynJEgQbGgA+B
         Ai8V7ikgT0jPBwopEwb7Gi5xI74zIybVUx4D7jTGq3n+1/eUFDkx2hHl9kzp0xn4lRzW
         U/LA==
X-Gm-Message-State: AC+VfDxmhlxyCjHdC0AuuxzGvZQxidgsu7xdrypR+ArxcBT8zzQUq2H2
	mlYaywJss2lphBkxBfNLMadSafvWKVbqnYDFmd4sgJb3NHH5
X-Google-Smtp-Source: ACHHUZ425+S4Rwvcf4mHf7HtjN+zBuiELldkf+mFP2JNM8oL3UPrGLaUDPDDT2n4OIihNiGs92v9lY9bntXfJ2Bsn1ny+XLZItyq
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:85c9:0:b0:418:4e31:5515 with SMTP id
 d67-20020a0285c9000000b004184e315515mr131232jai.6.1683702296004; Wed, 10 May
 2023 00:04:56 -0700 (PDT)
Date: Wed, 10 May 2023 00:04:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042cd3a05fb517ddd@google.com>
Subject: [syzbot] Monthly bpf report (May 2023)
From: syzbot <syzbot+list4cad303415e4d3e9ce58@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 2 new issues were detected and 1 were fixed.
In total, 5 issues are still open and 179 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 174     Yes   WARNING in bpf_xdp_adjust_tail (4)
                  https://syzkaller.appspot.com/bug?extid=f817490f5bd20541b90a
<2> 6       Yes   WARNING in bpf_verifier_vlog
                  https://syzkaller.appspot.com/bug?extid=8b2a08dfbd25fd933d75
<3> 4       No    KCSAN: data-race in __bpf_lru_list_rotate / __htab_lru_percpu_map_update_elem (5)
                  https://syzkaller.appspot.com/bug?extid=ebe648a84e8784763f82

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

