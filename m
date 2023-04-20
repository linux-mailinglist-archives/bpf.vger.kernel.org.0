Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166546E94CC
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 14:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjDTMoS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 08:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjDTMoR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 08:44:17 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FF44221
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 05:44:14 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2a8b082d6feso4806641fa.2
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 05:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681994653; x=1684586653;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7A3XNquHP01Ls3dIS59BfnUzBFXDs2FtmbS6CdQ0NZ4=;
        b=nxKoAjYHrtIBXT9boVd/ZqxYNLvwL3rVUDWXkNuxq7cMHjnlKHWXb76wRcuL261ALf
         kMUEs+Zygm+dzWe7W3bF0LV64qwLYstxeKkOczAGEq28GPgObADNFESlFjS9A8T9WPFg
         Uvc4A1LDT3Et/gM41AIZ+KpJ/svUK6AYk0VUhEUJJ9C5HEDheuBp1BU1zCo9aH0OAYKC
         lP8X9Xd5fsAq/TlKPQv8LhyVHYSVibAIuscBWV8naFVbB1d+zKQnvO3QDe5XBfBp7m5P
         rm0yThALoCx9jrRIPs45aVregszaW8Z4BzhCzQ4G4GqcLr4wzWrhLxrzcz76moMriLbQ
         CK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681994653; x=1684586653;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7A3XNquHP01Ls3dIS59BfnUzBFXDs2FtmbS6CdQ0NZ4=;
        b=NAjNNL5R2qHPnwTuIJnCFcZ/X7Vi3MiTpqAMolboe/42HRkklnct3E/vixuzNe4PZU
         Lm3hlVyrDNyzbFXrjGGuL44E0m5hP6GM+JI1NrhxnrYk4ILqDSNOjE5O5moM5Fow9fOO
         HQ9rxrHhj6TAWm20u69uWje0KAXEDSagilc/e75kUC3UgUtcgtIoqlPQ9ULsO1MswAyC
         Dk0AjiBnWSkLBhlX2qUmiPr8npdqcZRChDEtJvZc413JIfPBJZ9bZaDQ2/gV1o7/Qa7D
         Qw/Wt1vQz5Tre7397f+Kx6JQAaTHjEq2LdIyrQeKDos60xokbmdNzzucxMcOvHk5kZUn
         XAgw==
X-Gm-Message-State: AAQBX9coHCgX2E4DuhPNvVKzAuDAZ1wcJzhKA7J75WwSAfsaaDAXVP9r
        5iheiXsF2beZLj8jcJyjnB9Ndp7pOg8glA==
X-Google-Smtp-Source: AKy350aGR7+L5Uyc9lv1/vbudeV1u4uEl25Z7kxHwsHwoebtH+79PRUOAWcT4x4XGFliIbQ62GNNAQ==
X-Received: by 2002:ac2:59ca:0:b0:4ed:c17c:16e5 with SMTP id x10-20020ac259ca000000b004edc17c16e5mr514795lfn.17.1681994652827;
        Thu, 20 Apr 2023 05:44:12 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c26-20020ac2415a000000b004a6f66eed7fsm206767lfi.165.2023.04.20.05.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 05:44:11 -0700 (PDT)
Message-ID: <8c669c50ac494b9618e913f2e4096d5bdd8e2ee0.camel@gmail.com>
Subject: Re: bpf-next hang+kasan uaf refcount acquire splat when running
 test_progs
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Florian Westphal <fw@strlen.de>, bpf@vger.kernel.org
Cc:     Dave Marchevsky <davemarchevsky@fb.com>
Date:   Thu, 20 Apr 2023 15:44:10 +0300
In-Reply-To: <ZEEp+j22imoN6rn9@strlen.de>
References: <ZEEp+j22imoN6rn9@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2023-04-20 at 14:03 +0200, Florian Westphal wrote:
> Hello,
>=20
> while working on bpf-netfilter test cases i found that test_progs
> never invokes bpf_test_run().
>=20
> After applying following small patch it gets called as expected.
>=20
> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/se=
lftests/bpf/test_loader.c
> index 47e9e076bc8f..e2a1bdc5a570 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -587,7 +587,7 @@ void run_subtest(struct test_loader *tester,
>                 /* For some reason test_verifier executes programs
>                  * with all capabilities restored. Do the same here.
>                  */
> -               if (!restore_capabilities(&caps))
> +               if (restore_capabilities(&caps))
>                         goto tobj_cleanup;
>=20
>                 do_prog_test_run(bpf_program__fd(tprog), &retval);
>=20
> ... but then output just hangs.  With KASAN enabled I see following splat=
,
> followed by a refcount saturation warning:
>=20
> BUG: KASAN: slab-out-of-bounds in bpf_refcount_acquire_impl+0x63/0xd0
> Write of size 4 at addr ffff8881072b34e8 by task new_name/12847
>=20
> CPU: 1 PID: 12847 Comm: new_name Not tainted 6.3.0-rc6+ #129
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-202208=
07_005459-localhost 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x32/0x40
>  print_address_description.constprop.0+0x2b/0x3d0
>  ? bpf_refcount_acquire_impl+0x63/0xd0
>  print_report+0xb0/0x260
>  ? bpf_refcount_acquire_impl+0x63/0xd0
>  ? kasan_addr_to_slab+0x9/0x70
>  ? bpf_refcount_acquire_impl+0x63/0xd0
>  kasan_report+0xad/0xd0
>  ? bpf_refcount_acquire_impl+0x63/0xd0
>  kasan_check_range+0x13b/0x190
>  bpf_refcount_acquire_impl+0x63/0xd0
>  bpf_prog_affcc6c9d58016ca___insert_in_tree_and_list+0x54/0x131
>  bpf_prog_795203cdef4805f4_insert_and_remove_tree_true_list_true+0x15/0x1=
1b
>  bpf_test_run+0x2a0/0x5f0
>  ? bpf_test_timer_continue+0x430/0x430
>  ? kmem_cache_alloc+0xe5/0x260
>  ? kasan_set_track+0x21/0x30
>  ? krealloc+0x9e/0xe0
>  bpf_prog_test_run_skb+0x890/0x1270
>  ? __kmem_cache_free+0x9f/0x170
>  ? bpf_prog_test_run_raw_tp+0x570/0x570
>  ? __fget_light+0x52/0x4d0
>  ? map_update_elem+0x680/0x680
>  __sys_bpf+0x75e/0xd10
>  ? bpf_link_by_id+0xa0/0xa0
>  ? rseq_get_rseq_cs+0x67/0x650
>  ? __blkcg_punt_bio_submit+0x1b0/0x1b0
>  __x64_sys_bpf+0x6f/0xb0
>  do_syscall_64+0x3a/0x80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f2f6a8b392d
> Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 8b 0d d3 e4 0c 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffe46938328 EFLAGS: 00000206 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 0000000007150690 RCX: 00007f2f6a8b392d
> RDX: 0000000000000050 RSI: 00007ffe46938360 RDI: 000000000000000a
> RBP: 00007ffe46938340 R08: 0000000000000064 R09: 00007ffe46938360
> R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
> R13: 00007ffe46938b78 R14: 0000000000e09db0 R15: 00007f2f6a9ff000
>  </TASK>
>=20
> I can also reproduce this on bpf-next/780c69830ec6b27e0224586ce26bc89552f=
cf163.
> Is this a known bug?

Hi Florian,

Thank you for the report, that's my bug :(

After the suggested change I can run the ./test_progs till the end
 (takes a few minutes, though). One test is failing: verifier_array_access,
this is because map it uses is not populated with values (as it was when th=
is was
a part ./test_verifier).

However, in the middle of execution I do see a trace similar to yours:

[   82.757127] ------------[ cut here ]------------
[   82.757667] refcount_t: saturated; leaking memory.
[   82.758098] WARNING: CPU: 0 PID: 176 at lib/refcount.c:22 refcount_warn_=
saturate+0x61/0xe0
[   82.758775] Modules linked in: bpf_testmod(OE) [last unloaded: bpf_testm=
od(OE)]
[   82.759369] CPU: 0 PID: 176 Comm: new_name Tainted: G        W  OE      =
6.3.0-rc6-01631-g780c69830ec6 #474
[   82.760145] RIP: 0010:refcount_warn_saturate+0x61/0xe0
[   82.760578] Code: 05 84 3a 34 01 01 e8 be 1a b5 ff 0f 0b c3 80 3d 78 3a =
34 01 00 75 d7 48 c7 c7 d0 b0 0d 82 c6 05 68 3a 34 01 01 e8 9f 1a b5 ff <0f=
> 0b c3 80 3d 58 3a 34 01 00 75 b8 48 c7 c7 f8
[   82.762066] RSP: 0018:ffffc90000ac7c80 EFLAGS: 00010282
[   82.762491] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[   82.763078] RDX: 0000000000000202 RSI: 00000000ffffffea RDI: 00000000000=
00001
[   82.763674] RBP: ffffc90000ac7cb0 R08: ffffffff82745808 R09: 00000000fff=
fdfff
[   82.764279] R10: ffffffff82665820 R11: ffffffff82715820 R12: ffff888102b=
db128
[   82.764888] R13: ffffc9000011d048 R14: ffff888102bdb128 R15: 00000000000=
00000
[   82.765490] FS:  00007fde45dd1b80(0000) GS:ffff88817bc00000(0000) knlGS:=
0000000000000000
[   82.766183] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   82.766662] CR2: 00007fde455ce000 CR3: 0000000102f55000 CR4: 00000000003=
506b0
[   82.767226] Call Trace:
[   82.767430]  <TASK>
[   82.767618]  bpf_refcount_acquire_impl+0x3a/0x50
[   82.767995]  bpf_prog_a89006de37d09e06___insert_in_tree_and_list+0x54/0x=
131
[   82.768556]  bpf_prog_7c093a5d96bc51b4_insert_and_remove_tree_false_list=
_false+0x15/0xf2
[   82.769195]  bpf_test_run+0x17f/0x300
[   82.769599]  bpf_prog_test_run_skb+0x35c/0x700
[   82.770014]  __sys_bpf+0xa0b/0x2ca0
[   82.770328]  __x64_sys_bpf+0x1a/0x20
[   82.770680]  do_syscall_64+0x35/0x80
[   82.771019]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[   82.771474] RIP: 0033:0x7fde45ed45a9
[   82.771805] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 27 08 0d 08
[   82.773409] RSP: 002b:00007ffe2a7fee68 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000141
[   82.774088] RAX: ffffffffffffffda RBX: 000055b0c518f5f0 RCX: 00007fde45e=
d45a9
[   82.774707] RDX: 0000000000000050 RSI: 00007ffe2a7feeb0 RDI: 00000000000=
0000a
[   82.775318] RBP: 00007ffe2a7fee80 R08: 0000000000000064 R09: 00007ffe2a7=
feeb0
[   82.775924] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000=
00000
[   82.776534] R13: 00007

Could you please share your config?
I'd like to reproduce the hang.

Thanks,
Eduard

>=20
> If you can't reproduce this I can make .config available.
>=20
> Thanks.

