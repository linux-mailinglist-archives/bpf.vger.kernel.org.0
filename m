Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD8635FE03
	for <lists+bpf@lfdr.de>; Thu, 15 Apr 2021 00:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhDNWr7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 18:47:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53843 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232276AbhDNWr4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 14 Apr 2021 18:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618440452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zZtDRk76kxvuyZMpKQkeaW0pQd7ky8KLp6aKBfZRByA=;
        b=Jq5SnhxvbxIuv92OuLx+pqqxUfrcolkZVMc3StimqQi4BKq+wxGGH0Ki29xC15lTOwoRdq
        XdAczNyf2bog/MUh+Q+SU7S6NmlI2tCItkuLRpaZy9E/76VEo5f8njKk/9ami6qbo452k2
        u4BT/RPJKwO/lEUePj4boF9iVEUEWXs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-0u8wIvdnPh2h4gEW0UNwfQ-1; Wed, 14 Apr 2021 18:47:31 -0400
X-MC-Unique: 0u8wIvdnPh2h4gEW0UNwfQ-1
Received: by mail-ed1-f70.google.com with SMTP id o4-20020a0564024384b0290378d45ecf57so4113192edc.12
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 15:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=zZtDRk76kxvuyZMpKQkeaW0pQd7ky8KLp6aKBfZRByA=;
        b=XmPo49mAufbghMiGwWg4svHxGyuo2YsQAJbTEvVDb5S3E6BpzxwV5xw+rD86dQG2N6
         jGUqcakLMf5Y83FJUyNCK34BxdP5rSozqFAed0cAto1HEggZCusJLnlovJg4El8ZjuCB
         7udu/3IYuOhm0cYTBHcE7OloHhI3RAohy9erkiOapqnW9Q7xZZnqyAiOm8wx+suJwyl4
         H4ZQwFG6XYc7eQnrT6h8FKh2bj3xS31jcKrmPpWYesZuKyuGxpuhFoHMJg5zxPWB6rtx
         TwcAcJa0bO4KQutc8S4Ee9Rf5qTnzCjQuH1AYuPG+i348n++iFf+M3V9GN1eMBM/umM/
         Ui8A==
X-Gm-Message-State: AOAM5301oo7Q9UebonFX2Z18mLnVfYFrFtrJGPBXeBcnR7a+ftsithhx
        lY0ibRnIPrGbKlzTh/UMIZrZVcg3XQwe+ES3J8EO27JRmUNnmtK1+mSGyIkT9OcxrcVadVLyJSe
        4V1XEQinvlu42
X-Received: by 2002:a17:906:aec6:: with SMTP id me6mr388814ejb.52.1618440449682;
        Wed, 14 Apr 2021 15:47:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1dWjyMztVg8p1Hs/Jbvr606CujLSwdhMi0WrjjOOPV49hiBCyQlP/t/klB6L47lJKaim/5g==
X-Received: by 2002:a17:906:aec6:: with SMTP id me6mr388783ejb.52.1618440449246;
        Wed, 14 Apr 2021 15:47:29 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id b8sm746357edu.41.2021.04.14.15.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 15:47:28 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0DFBA1806B3; Thu, 15 Apr 2021 00:47:27 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: Selftest failures related to kern_sync_rcu()
In-Reply-To: <CAEf4BzZ=oFbTaS2DPOry8jbunb2Qtu4omF3VsYMNJ5_8VNHoQw@mail.gmail.com>
References: <CAEf4Bzb4LDi1ZVrhNEojpWhxi33tkv4rv6F7Czj28Y0tHxXh0w@mail.gmail.com>
 <87im4qo9ey.fsf@toke.dk>
 <CAEf4Bzahxw5-KTb2yOk8PHQmEyc6gDgTTR6znZjH2OhZ66wiUw@mail.gmail.com>
 <CAADnVQ+6xoBaD1GSSm=U3n67ooHvjGgxXPAHmFD6AhksrM8BoQ@mail.gmail.com>
 <20210414175245.GT4510@paulmck-ThinkPad-P17-Gen-1>
 <CAADnVQKyHb-j3-DSzF1wbzxYR39HdQiJVTVv1NkBS+9ZEeiEvg@mail.gmail.com>
 <20210414181934.GV4510@paulmck-ThinkPad-P17-Gen-1>
 <87czuwlnhz.fsf@toke.dk>
 <20210414184133.GW4510@paulmck-ThinkPad-P17-Gen-1>
 <87a6q0llou.fsf@toke.dk>
 <20210414212502.GX4510@paulmck-ThinkPad-P17-Gen-1>
 <CAEf4BzZ=oFbTaS2DPOry8jbunb2Qtu4omF3VsYMNJ5_8VNHoQw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 15 Apr 2021 00:47:27 +0200
Message-ID: <87zgy0jxfk.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Wed, Apr 14, 2021 at 2:25 PM Paul E. McKenney <paulmck@kernel.org> wro=
te:
>>
>> On Wed, Apr 14, 2021 at 09:18:09PM +0200, Toke H=C3=B8iland-J=C3=B8rgens=
en wrote:
>> > "Paul E. McKenney" <paulmck@kernel.org> writes:
>> >
>> > > On Wed, Apr 14, 2021 at 08:39:04PM +0200, Toke H=C3=B8iland-J=C3=B8r=
gensen wrote:
>> > >> "Paul E. McKenney" <paulmck@kernel.org> writes:
>> > >>
>> > >> > On Wed, Apr 14, 2021 at 10:59:23AM -0700, Alexei Starovoitov wrot=
e:
>> > >> >> On Wed, Apr 14, 2021 at 10:52 AM Paul E. McKenney <paulmck@kerne=
l.org> wrote:
>> > >> >> >
>> > >> >> > > > > >                 if (num_online_cpus() > 1)
>> > >> >> > > > > >                         synchronize_rcu();
>> > >> >> >
>> > >> >> > In CONFIG_PREEMPT_NONE=3Dy and CONFIG_PREEMPT_VOLUNTARY=3Dy ke=
rnels, this
>> > >> >> > synchronize_rcu() will be a no-op anyway due to there only bei=
ng the
>> > >> >> > one CPU.  Or are these failures all happening in CONFIG_PREEMP=
T=3Dy kernels,
>> > >> >> > and in tests where preemption could result in the observed fai=
lures?
>> > >> >> >
>> > >> >> > Could you please send your .config file, or at least the relev=
ant portions
>> > >> >> > of it?
>> > >> >>
>> > >> >> That's my understanding as well. I assumed Toke has preempt=3Dy.
>> > >> >> Otherwise the whole thing needs to be root caused properly.
>> > >> >
>> > >> > Given that there is only a single CPU, I am still confused about =
what
>> > >> > the tests are expecting the membarrier() system call to do for th=
em.
>> > >>
>> > >> It's basically a proxy for waiting until the objects are freed on t=
he
>> > >> kernel side, as far as I understand...
>> > >
>> > > There are in-kernel objects that are freed via call_rcu(), and the i=
dea
>> > > is to wait until these objects really are freed?  Or am I still miss=
ing
>> > > out on what is going on?
>> >
>> > Something like that? Although I'm not actually sure these are using
>> > call_rcu()? One of them needs __put_task_struct() to run, and the other
>> > waits for map freeing, with this comment:
>> >
>> >
>> >       /* we need to either wait for or force synchronize_rcu(), before
>> >        * checking for "still exists" condition, otherwise map could st=
ill be
>> >        * resolvable by ID, causing false positives.
>> >        *
>> >        * Older kernels (5.8 and earlier) freed map only after two
>> >        * synchronize_rcu()s, so trigger two, to be entirely sure.
>> >        */
>> >       CHECK(kern_sync_rcu(), "sync_rcu", "failed\n");
>> >       CHECK(kern_sync_rcu(), "sync_rcu", "failed\n");
>>
>> OK, so the issue is that the membarrier() system call is designed to for=
ce
>> ordering only within a user process, and you need it in the kernel.
>>
>> Give or take my being puzzled as to why the membarrier() system call
>> doesn't do it for you on a CONFIG_PREEMPT_NONE=3Dy system, this brings
>> us back to the question Alexei asked me in the first place, what is the
>> best way to invoke an in-kernel synchronize_rcu() from userspace?
>>
>> You guys gave some reasonable examples.  Here are a few others:
>>
>> o       Bring a CPU online, then force it offline, or vice versa.
>>         But in this case, sys_membarrier() would do what you need
>>         given more than one CPU.
>>
>> o       Use the membarrier() system call, but require that the tests
>>         run on systems with at least two CPUs.
>>
>> o       Create a kernel module whose init function does a
>>         synchronize_rcu() and then returns failure.  This will
>>         avoid the overhead of removing that kernel module.
>>
>> o       Create a sysfs or debugfs interface that does a
>>         synchronize_rcu().
>>
>> But I am still concerned that you are needing more than synchronize_rcu()
>> can do.  Otherwise, the membarrier() system call would work just fine
>> on a single CPU on your CONFIG_PREEMPT_VOLUNTARY=3Dy kernel.
>
> Selftests know internals of kernel implementation and wait for some
> objects to be freed with call_rcu(). So I think at this point the best
> way is just to go back to map-in-map or socket local storage.
> Map-in-map will probably work on older kernels, so I'd stick with that
> (plus all the code is there in the referenced commit). The performance
> and number of syscalls performed doesn't matter, really.

Just tried that (with the patch below, pulled from the commit you
referred), and that doesn't help. Still get this with a single CPU:

test_lookup_update:FAIL:map1_leak inner_map1 leaked!
#15/1 lookup_update:FAIL
#15 btf_map_in_map:FAIL

It's fine with 2 CPUs. And the other failures (in the task_local_storage
test) seem to have gone away entirely after I just pulled the newest
bpf-next...

-Toke


diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selft=
ests/bpf/test_progs.c
index 6396932b97e2..4c26d84a64dc 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -376,7 +376,25 @@ static int delete_module(const char *name, int flags)
  */
 int kern_sync_rcu(void)
 {
-	return syscall(__NR_membarrier, MEMBARRIER_CMD_SHARED, 0, 0);
+	int inner_map_fd, outer_map_fd, err, zero =3D 0;
+
+	inner_map_fd =3D bpf_create_map(BPF_MAP_TYPE_ARRAY, 4, 4, 1, 0);
+	if (!ASSERT_LT(0, inner_map_fd, "inner_map_create"))
+		return -1;
+
+	outer_map_fd =3D bpf_create_map_in_map(BPF_MAP_TYPE_ARRAY_OF_MAPS, NULL,
+					     sizeof(int), inner_map_fd, 1, 0);
+	if (!ASSERT_LT(0, outer_map_fd, "outer_map_create")) {
+		close(inner_map_fd);
+		return -1;
+	}
+
+	err =3D bpf_map_update_elem(outer_map_fd, &zero, &inner_map_fd, 0);
+	if (err)
+		err =3D -errno;
+	ASSERT_OK(err, "outer_map_update");
+	close(inner_map_fd);
+	close(outer_map_fd);
 }
=20
 static void unload_bpf_testmod(void)

