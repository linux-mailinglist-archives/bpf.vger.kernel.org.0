Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4205277B96
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 00:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgIXWUT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 18:20:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36371 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726559AbgIXWUP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Sep 2020 18:20:15 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600986013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gicLReVLSkO0rbJ1N5yp+c4JgeuD2b5/KdORfLV1Ngw=;
        b=FJk7mgQQukxRWSgK86oF0aW2QPQlYlB1TGnkNopCTCaxONALYmtpBg2wUZo+Fwo02xiIS2
        GtM2RuWL+GPeaJRPphIu2Gj6rqisdtUPFl7v2wLF7tPEnsI2lDS75B37J2Aa4e3ZSDz02V
        m8sY4Egt1QVxpiO49mWFi55jO0RJf6Q=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-3aJTwqp_Nk6qBN1utNMSUA-1; Thu, 24 Sep 2020 18:20:08 -0400
X-MC-Unique: 3aJTwqp_Nk6qBN1utNMSUA-1
Received: by mail-pf1-f198.google.com with SMTP id q2so321382pfc.17
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 15:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=gicLReVLSkO0rbJ1N5yp+c4JgeuD2b5/KdORfLV1Ngw=;
        b=djqTm+Nc6QpJmydj5osRc6bXHnYLxFuqS/tlz63U/5l/MeD2vasUvyDlu8zNBnvOvg
         DshHZlVhjiw5mkPypVUJW1rNHpnygNpNZNZwq7UyfgNhKNMErcTfbU9Zy+CD0VmRlrjV
         Tk/y+nyn8mRe7+IqnXP47rFVdLRU/0hd72ybFCjRUe2TqMUVFSp45pjPLThzCA9640Gx
         5AyJN6VoPjL/X+jzoLDoNOA1qmiDENl5tcAZGkOJ3imfjdq7U0Xu1+vWp0CxN4gB88ZX
         ETOr9d/wJsHVwiuwhej4A0MYF7/MftGnvzy8z8zu4ulKCnDn5A6uWof0bhxPt7yG552o
         60Hg==
X-Gm-Message-State: AOAM530JrhLkXOM4DEBpn+enySxQfK4ChH5h07cD90Niok8gNriHuLIP
        JsQ3UL2xyfBXdtHyN6iBlxkwEJDHnhwo+i3TNauawyMXurnS0kppoIPEcYXNgWQ5gaetKhTGzXM
        n1Ov71amkNYJ/
X-Received: by 2002:a65:67d7:: with SMTP id b23mr988317pgs.362.1600986007562;
        Thu, 24 Sep 2020 15:20:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNgdyFIzfaog/z86armQTiy/M3hWMsEEfnrrPnnvdjFOqYhXYPjwwQcbyQgwiQR4TUEB8Gwg==
X-Received: by 2002:a65:67d7:: with SMTP id b23mr988288pgs.362.1600986007135;
        Thu, 24 Sep 2020 15:20:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id bx18sm284100pjb.6.2020.09.24.15.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 15:20:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8535A183A90; Fri, 25 Sep 2020 00:20:01 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jakub Sitnicki <jakub@cloudflare.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        KP Singh <kpsingh@chromium.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v8 04/11] bpf: move prog->aux->linked_prog and
 trampoline into bpf_link on attach
In-Reply-To: <CAEf4BzZxfzQabDCdmby1XMQV7qQ_C=rATWOb=cN-Q1rfxR+nVA@mail.gmail.com>
References: <160079991372.8301.10648588027560707258.stgit@toke.dk>
 <160079991808.8301.6462172487971110332.stgit@toke.dk>
 <20200924001439.qitbu5tmzz55ck4z@ast-mbp.dhcp.thefacebook.com>
 <874knn1bw4.fsf@toke.dk>
 <CAEf4BzaBvvZdgekg13T3e4uj5Q9Rf1RTFP__ZPsU-NMp2fVXxw@mail.gmail.com>
 <87zh5ec1gs.fsf@toke.dk>
 <CAEf4BzZxfzQabDCdmby1XMQV7qQ_C=rATWOb=cN-Q1rfxR+nVA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 25 Sep 2020 00:20:01 +0200
Message-ID: <87r1qqbywe.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Sep 24, 2020 at 2:24 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> > On Thu, Sep 24, 2020 at 7:36 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke=
@redhat.com> wrote:
>> >>
>> >> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>> >>
>> >> > On Tue, Sep 22, 2020 at 08:38:38PM +0200, Toke H=C3=83=C6=92=C3=82=
=C2=B8iland-J=C3=83=C6=92=C3=82=C2=B8rgensen wrote:
>> >> >> @@ -746,7 +748,9 @@ struct bpf_prog_aux {
>> >> >>      u32 max_rdonly_access;
>> >> >>      u32 max_rdwr_access;
>> >> >>      const struct bpf_ctx_arg_aux *ctx_arg_info;
>> >> >> -    struct bpf_prog *linked_prog;
>> >> >
>> >> > This change breaks bpf_preload and selftests test_bpffs.
>> >> > There is really no excuse not to run the selftests.
>> >>
>> >> I did run the tests, and saw no more breakages after applying my patc=
hes
>> >> than before. Which didn't catch this, because this is the current sta=
te
>> >> of bpf-next selftests:
>> >>
>> >> # ./test_progs  | grep FAIL
>> >> test_lookup_update:FAIL:map1_leak inner_map1 leaked!
>> >> #10/1 lookup_update:FAIL
>> >> #10 btf_map_in_map:FAIL
>> >
>> > this failure suggests you are not running the latest kernel, btw
>>
>> I did see that discussion (about the reverted patch), and figured that
>> was the case. So I did a 'git pull' just before testing, and still got
>> this.
>>
>> $ git describe HEAD
>> v5.9-rc3-2681-g182bf3f3ddb6
>>
>> so any other ideas? :)
>
> That memory leak was fixed in 1d4e1eab456e ("bpf: Fix map leak in
> HASH_OF_MAPS map") at the end of July. So while your git repo might be
> checked out on a recent enough commit, could it be that the kernel
> that you are running is not what you think you are running?

Nah, I'm running these in a one-shot virtual machine with virtme-run.

> I specifically built kernel from the same commit and double-checked:
>
> [vmuser@archvm bpf]$ uname -r
> 5.9.0-rc6-01779-g182bf3f3ddb6
> [vmuser@archvm bpf]$ sudo ./test_progs -t map_in_map
> #10/1 lookup_update:OK
> #10/2 diff_size:OK
> #10 btf_map_in_map:OK
> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED

Trying the same, while manually entering the VM:

[root@(none) bpf]# uname -r
5.9.0-rc6-02685-g64363ff12e8f
[root@(none) bpf]# ./test_progs -t map_in_map
test_lookup_update:PASS:skel_open 0 nsec
test_lookup_update:PASS:skel_attach 0 nsec
test_lookup_update:PASS:inner1 0 nsec
test_lookup_update:PASS:inner2 0 nsec
test_lookup_update:PASS:inner1 0 nsec
test_lookup_update:PASS:inner2 0 nsec
test_lookup_update:PASS:map1_id 0 nsec
test_lookup_update:PASS:map2_id 0 nsec
kern_sync_rcu:PASS:inner_map_create 0 nsec
kern_sync_rcu:PASS:outer_map_create 0 nsec
kern_sync_rcu:PASS:outer_map_update 0 nsec
test_lookup_update:PASS:sync_rcu 0 nsec
kern_sync_rcu:PASS:inner_map_create 0 nsec
kern_sync_rcu:PASS:outer_map_create 0 nsec
kern_sync_rcu:PASS:outer_map_update 0 nsec
test_lookup_update:PASS:sync_rcu 0 nsec
test_lookup_update:FAIL:map1_leak inner_map1 leaked!
#10/1 lookup_update:FAIL
#10/2 diff_size:OK
#10 btf_map_in_map:FAIL
Summary: 0/1 PASSED, 0 SKIPPED, 2 FAILED


>> >> configure_stack:FAIL:BPF load failed; run with -vv for more info
>> >> #72 sk_assign:FAIL
>>
>> (and what about this one, now that I'm asking?)
>
> Did you run with -vv? Jakub Sitnicki (cc'd) might probably help, if
> you provide a bit more details.

No, I didn't, silly me. Turned out that was also just a missing config
option - thanks! :)

>> One thing that would be really useful would be to have a 'reference
>> config' or something like that. Missing config options are a common
>> reason for test failures (as we have just seen above), and it's not
>> always obvious which option is missing for each test. Even something
>> like grepping .config for BPF doesn't catch everything. If you already
>> have a CI running, just pointing to that config would be a good start
>> (especially if it has history). In an ideal world I think it would be
>> great if each test could detect whether the kernel has the right config
>> set for its features and abort with a clear error message if it isn't...
>
> so tools/testing/selftests/bpf/config is intended to list all the
> config values necessary, but given we don't update them often we
> forget to update them when selftests requiring extra kernel config are
> added, unfortunately.

Ah, that's useful! I wonder how difficult it would be to turn this into
a 'make bpfconfig' top-level make target (similar to 'make defconfig')?

That way, it could be run automatically, and we would also catch
anything missing?

> As for CI's config, check [0], that's what we use to build kernels.
> Kernel config is intentionally pretty minimal and is running in a
> single-user mode in pretty stripped down environment, so might not
> work as is for full-blown VM. But you can still take a look.
>
>   [0] https://github.com/libbpf/libbpf/blob/master/travis-ci/vmtest/confi=
gs/latest.config

Well that's how I'm running my own tests (as mentioned above), so that
might be useful, actually! I'll go take a look, thanks :)

-Toke

