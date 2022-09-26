Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA485EADB1
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 19:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiIZRKr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 13:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiIZRK3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 13:10:29 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EA02610F
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 09:18:53 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4MbnrM14glz9xGYl
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 00:14:11 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCnnpLW0DFjcXB5AA--.28389S2;
        Mon, 26 Sep 2022 17:18:37 +0100 (CET)
Message-ID: <06a47f11778ca9d074c815e57dc1c75d073b3a85.camel@huaweicloud.com>
Subject: Re: Closing the BPF map permission loophole
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Lorenz Bauer <oss@lmb.io>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org
Date:   Mon, 26 Sep 2022 18:18:27 +0200
In-Reply-To: <98a26e5c-d44f-4e65-8186-c4e94918daa1@www.fastmail.com>
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
         <8e243ad132ecf2885fc65c33c7793f0703937890.camel@huaweicloud.com>
         <7f7c3337-74f1-424e-a14d-578c4c7ee2fe@www.fastmail.com>
         <65546f56be138ab326544b7b2e59bb3175ec884a.camel@huaweicloud.com>
         <b0c00f80-c11e-4f5d-ba63-2e9fb7cad561@www.fastmail.com>
         <9aba20351924aa0d82d258205030ad4f2c404de2.camel@huaweicloud.com>
         <98a26e5c-d44f-4e65-8186-c4e94918daa1@www.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwCnnpLW0DFjcXB5AA--.28389S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw18Zr4kAFyrZFW7KFWktFb_yoW8Kr4DpF
        WrJF42kr4kJ342kFZYgFWxt3W0vws8WryUXFySq345Aw1Y9Fn8WFWIkFWF9FW7Crsa93yY
        vrZ0v3s8JF90va7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr
        1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
        daVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj4N4HAACsW
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2022-09-26 at 16:35 +0100, Lorenz Bauer wrote:
> 
> On Fri, 23 Sep 2022, at 08:39, Roberto Sassu wrote:
> > > Yes please, I have also have a WIP patch that seems to work, but
> > > I'm
> > > curious what you came up with. Tests would also be great, mine
> > > are
> > > kinda janky.
> > 
> > Ok.
> 
> Hi Roberto,
> 
> Did you get around to putting your patches somewhere?
> 
> > If you have write access to /sys/fs/bpf/foo, it does not mean that
> > you
> > will have write access to the map, when you call OBJ_GET(). I don't
> > know if you could add more modes after getting a fd.
> 
> Well, that's kind of how it works at the moment. Write on the file
> gives write on the FD, and BPF_F_RDONLY, etc. can be passed to
> OBJ_GET to change that. You're proposing to change that?

Could it be that file permissions and fd permissions from OBJ_GET() are
independent?

You could decide to ask for any permission with bpf_obj_get_opts(). By
default, it is read/write.

> > > Ok, you're saying that a user can prevent the escalation via
> > > SELinux?
> > 
> > Not only with SELinux, but with an eBPF program too (BPF LSM). What
> > I
> > wanted to do is to deny write access to anyone except the eBPF
> > program
> > that declares the map.
> 
> There is no "ownership" of a map as far as I can tell. How would you
> figure out which program declared the map?

At least in SELinux, the label of the map is the label of the process
creating it:

static int selinux_bpf_map_alloc(struct bpf_map *map)
{
[...]
	bpfsec->sid = current_sid();

Accessing a map requires a rule allowing a subject to access maps with
that label.

> Maybe it's best not to focus on SELinux / LSM too much: this stuff
> should work correctly out of the box, without needing workarounds
> from the user.

Uhm, if I get what you mean, you would like to add DAC controls to the
pinned map to decide if you can get a fd and with which modes.

The problem I see is that a map exists regardless of the pinned path
(just by ID). DAC information should be rather added to the map object
itself.

> > I wrote an example here:
> > 
> > https://lore.kernel.org/bpf/8d7a713e500b5e3fce93e4c5c7b8841eb6dd28e4.camel@huaweicloud.com/
> 
> That was very helpful. Yes, map iterators semantics are also broken,
> just like program fds and link fds. I started with maps since that
> seemed easier to tackle than everything all at once.

Great!

Roberto

