Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4E7595F53
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 17:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbiHPPip (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 11:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235902AbiHPPiQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 11:38:16 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEC185FB0
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660664242; bh=h2+uBqaU3QflZmlGyWerTZwwwL4BbriDFECIpmxJNr8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=MjpUlhRJ7bxNQtLy/RUjvucD7+fGPiZ/vVFga2/0Y9AnnNB8KKasHS1aamU3UEHH3PVlP7ZnglmiXJ+lnxVanUvkUIdJPC/sbThpnKOv5YZ8M0K0MAIAWOD8Rtxp0mptqpmGPWTD0aJELpHW3VHR8Krfrd9cW+xvam+KiLq0hUzk5sC80egBaAKtqGbqzdt1EmPBea5E2rSAYGq6q++5V6SzcI6UouKYXYkDyRgCwQnylNHWkkCg3jwjKGyb+3XTB6iwZuBYWLiiyfNcOkeD5LlujZdQYUUcdevFs8GKvdR9wga9vaM3SgGFdsqLl/LQjnIFxLEtvDbZ9OgWr5oDlQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660664242; bh=WS516hGrFdeCGL4ttL+UaT0Lc+5piOM8lLS07F7rE38=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=VTmALvToRZiHrBFGD1brprH96U97LQQhtzK4GSWzUavDz9UAiIfl+Hvq+Hegq+9FzB5FMm7JFT5cKZaxsC+z96/VRJ9fHWq0eo/NupTHleknEpryUh4Cs7/ZzA/Runxp3s22g9r91R2yCxkuL1qmbAwNC2OHN+lyq+MjSgzLg7zQ14mIPu9stsC6CeQpJASPadejesAlJtrDJT2tkcypKNUpKlBILBSTw0gsnqgwvobtX1lHCQAPf2nuXH3t7PB7AfFAdIoWO/JOd9WBufZor74nFji/7ToDfh7v+RGeiyOGMCvL/m5hhtH4xgVxDd09e0slGiShOPnaNkjyNtRC+g==
X-YMail-OSG: ztHmSBoVM1lV4DhoZ5snreo83bJ9zEUVgF5RBvD_kqlgH2dpUDDhqnhxVXAvKgG
 JZzlOMha8I7q52bA1YHQuzB6UIwdQ0AzBbBVNfySUMjDxN9cC7KBhHhlOEZr6LVsxVFKWQhv_mGD
 ysguAWxV6VeBc_Er2Kr82xHcib76zHK3LONqaKZNK3h5RG.Yj7PIMwIv9WSIk3UtGzlPrJ0tA1Np
 jSF0ivecSeM_ym5pyokWsm_9OZa1Oa6BgPKoT5NBABFEJcT_f8Byd19QFhHgTH8vwY_8uR8Acj1I
 dZt6aD_l7OQV3j20ZizrP7ll8RdFBw8IbeyoN3f4cwDzi0yDWD37VuVFJckftJRO.5HjE4HHhlTY
 zX8kfbvlU6Ukn935hWJfeZstLEL3EgO.ndAQlNLoinYWVpKqldiwHdrrxLMXIk.UIOmmGHjjSWb8
 4tHCOrDVCaCThwlNxlwN2XgfHGhy44U0Xx9y1m7EBg4JuD1gSTcWNxVUkmwTM8dlWcI8K2BCkKUQ
 5JW.oX_dljIKtQ10.k4Dx4C7XUdlmaqXCuvyaZy1YviGXkODHE_XBavuy2Aimp4pQ9oU.CJM_N_i
 Hg8CWHjxU4gaImxWN6HylCS3Z.p0EqGKwNLJfYG5P0LMTz6wneDp9bVT7HXaBzAnacQ9H_vv.s8s
 aJYPkeDffKlKCy_GBzDf191wPdvHDlTR1pt.nS2OBewg0D7TtEFve7ATT3FNRrXLGqhbcXMNHmjI
 qzMxDyqG.uh96zZ87ZiUKyhKedDCDQSDhfanQ1Z60DiB_sD1C9dz9ZxV8DpbCDfbxojbQDN_ZZTd
 hDO2mx9d243pfaF2kGP1WvJh4Recp39dyhgo.d.PY3FGZocSybyCvoRkBqnl2mf_h5ZFMJV9Wqv8
 yL6avlOmQIMuTdBycIY0rUmhc1Um3u7TthYpfGVw79alFamSOlmyv.Amk4gQEOucWEvUDNcZyg95
 x2EsUlKv4nGMPvLJe1vssYd294Kfnp94k6ZGAmmv5QENogTDgH9KMjd3xUxoEOpRo5gq8F1VvkPw
 g5sT4MXpVnR1IVuxNKUpJA.ARZEgATPi0waf5AK85oyVnGkQT4tIC0kwzNPb__wf3V1mN3ZgV.wM
 qrrsWc0nwHrd_dK7RFNx1c0pBtBzNFXoL8UKiy3NIFRqS1dxSnzbIwddX_tqqGObPr41o_Z7Ad7L
 pBBpmZ4NtVY_4KS4nPCWUjELgnifolRCWFCG8vClVgzUinj9AUvvqcRWgOWvNB792x5IPP2szhBa
 Xag0bMpFEYmsTuNzZJHvbzAyUoSsVG.k01Pw3p6JBf1DUAU.FmM8H7LwbQBuIWA1XiLtAn9qxrz3
 4YeKtXM._a0Ju4esGrloiNY5AfJmWY5QjZvTOzcdrVaCQQsrG8kjpiZ8BYpFPXeI2.8HbZojZJHM
 GgtHQp9dZ6PJVtX6pKk04VgzhRf7WbhQiYU4nCUW.e1ossWQl9Fh_dSLrjP4KvZx7qjzOzD9W_ZG
 4pJbXS8A8Ue5gy0il0mhzzlqti5JwdAp8arPGubAHea2CSoQH2ItT37re9yJrdHSeywvA1MlkEoy
 zVn5biBq6IG23Ix33F8gyob8r0U1wlJTKUnPclH7TuX9yFc73E.sQuY6Okm6po048RU0Xr9yRbQ8
 2lfBgFO4YGWOGlijranm5Q37czPf.nTJlRb6SBRUAT5lKCUkNOWOem1Vvdo5Gzf.ncAVD5t7fhiE
 vA3Tfm3hsjE1.P.e84Y9kwpZ1Izc_cVrZKyvbWvuWFI2ogQn_tM8m7lBoK_3zyhja80bm8B2GboQ
 gCn4YZ2jP7saXy1l1IP9bBpb1Zj3HKv5exWkmAPwok3ZWM5pNB3hPssQ_hLxKqwJfy.6oLlRvG0y
 f.6La3YpLJd9h_TMWwzyfek.fn6nA.eu50I7gqdvI.HnCEm2jAhB_ToLODG5CYASarjkNgDtbRjn
 NaNQ.MQD2Y2fMV_h7Nu2.vAu8smOPZjSasxUKV5mictTTvImEGAF4HBFL127NlJg0gYGGqNweXPk
 rtnHPrDIgTHyCkNA.crojlF4P.yyy4_RsFBhZLdG5kyyndZhJOHUyAgpJpUSHVwlv1Z0V58sJ.9n
 dKbfX1jj4yIljmipvCC_nO4zoc3vEUfHItN2Hs3TG4s29p7p7jPuYNrzAP_RDMybpOQUvv6ai8Rk
 RtAgaQb2WMbULh0mbyJA4VbDyz5awbzLhxP1Sfm04Bb.6fyAFSTId3KgRlkOi3ER0jDRrAlWzogP
 KJ.9jwF_p7qySuk0IHOBSisIGNdMikdozh0qayF7Y2_BnF5FvipAimnwkHQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 16 Aug 2022 15:37:22 +0000
Received: by hermes--production-bf1-7586675c46-b9v2k (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f402ac616ebbedac2673a1c80cf846d4;
          Tue, 16 Aug 2022 15:37:21 +0000 (UTC)
Message-ID: <73ae74de-a1eb-b118-3e74-61f14b5561af@schaufler-ca.com>
Date:   Tue, 16 Aug 2022 08:37:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [syzbot] KASAN: use-after-free Read in sock_has_perm
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        syzbot <syzbot+2f2c6bea25b08dc06f86@syzkaller.appspotmail.com>
Cc:     anton@enomsg.org, bpf@vger.kernel.org, ccross@android.com,
        eparis@parisplace.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        stephen.smalley.work@gmail.com, syzkaller-bugs@googlegroups.com,
        tony.luck@intel.com, casey@schaufler-ca.com
References: <0000000000002c46ec05e6572415@google.com>
 <CAHC9VhQmtggv-P9RoG9mHp8JJMUB-qTWNiKVh8q4ygmdi-x2rA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQmtggv-P9RoG9mHp8JJMUB-qTWNiKVh8q4ygmdi-x2rA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20531 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/16/2022 8:01 AM, Paul Moore wrote:
> On Tue, Aug 16, 2022 at 4:00 AM syzbot
> <syzbot+2f2c6bea25b08dc06f86@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    200e340f2196 Merge tag 'pull-work.dcache' of git://git.ker..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=16021dfd080000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=f2886ebe3c7b3459
>> dashboard link: https://syzkaller.appspot.com/bug?extid=2f2c6bea25b08dc06f86
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+2f2c6bea25b08dc06f86@syzkaller.appspotmail.com
>>
>> ==================================================================
>> BUG: KASAN: use-after-free in sock_has_perm+0x258/0x280 security/selinux/hooks.c:4532
>> Read of size 8 at addr ffff88807630e480 by task syz-executor.0/8123
>>
>> CPU: 1 PID: 8123 Comm: syz-executor.0 Not tainted 5.19.0-syzkaller-02972-g200e340f2196 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
>> Call Trace:
>>  <TASK>
>>  __dump_stack lib/dump_stack.c:88 [inline]
>>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>>  print_address_description.constprop.0.cold+0xeb/0x467 mm/kasan/report.c:313
>>  print_report mm/kasan/report.c:429 [inline]
>>  kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
>>  sock_has_perm+0x258/0x280 security/selinux/hooks.c:4532
>>  selinux_socket_setsockopt+0x3e/0x80 security/selinux/hooks.c:4913
>>  security_socket_setsockopt+0x50/0xb0 security/security.c:2249
>>  __sys_setsockopt+0x107/0x6a0 net/socket.c:2233
>>  __do_sys_setsockopt net/socket.c:2266 [inline]
>>  __se_sys_setsockopt net/socket.c:2263 [inline]
>>  __x64_sys_setsockopt+0xba/0x150 net/socket.c:2263
>>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> RIP: 0033:0x7f96c7289279
>> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007f96c842f168 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
>> RAX: ffffffffffffffda RBX: 00007f96c739c050 RCX: 00007f96c7289279
>> RDX: 0000000000000007 RSI: 0000000000000103 RDI: 0000000000000004
>> RBP: 00007f96c72e3189 R08: 0000000000000004 R09: 0000000000000000
>> R10: 0000000020000000 R11: 0000000000000246 R12: 0000000000000000
>> R13: 00007ffe7030593f R14: 00007f96c842f300 R15: 0000000000022000
>>  </TASK>
> SELinux hasn't changed anything in this area for a while, and looking
> over everything again just now it still looks sane to me.  I suspect
> there is something else going on with respect to socket lifetimes and
> SELinux just happens to be the one that catches the use-after-free
> first.

I am trying to track down an intermittent UDP peersec failure in the
Smack stack as well. It could be related. There are no changes in the
Smack code that would account for it. 

