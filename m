Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50EC03BDA6B
	for <lists+bpf@lfdr.de>; Tue,  6 Jul 2021 17:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbhGFPrH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Jul 2021 11:47:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57550 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232502AbhGFPrG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 6 Jul 2021 11:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625586267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T2UPWIhoK4ShiSSNDhtKtJnetsTjyJJ0DdRImI232kk=;
        b=FVN7Rhpzq/QV+pi42HPsJy2nR3pWju4Kkq3pSew3aU1T+irVBV8azqD0cMt7FBQyD+S7mx
        el2sGRl2sUzb3MF+edBiOfagmvuPQrhjL9CAEtH5X8At8j3RwPmzsFZjdOa4mwtd6g1HBs
        MjKDt8zK+c2nOFyJkBoD4U4EDl5dUWA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-XHAQRTESMiSjIkkRxpJXcA-1; Tue, 06 Jul 2021 11:44:26 -0400
X-MC-Unique: XHAQRTESMiSjIkkRxpJXcA-1
Received: by mail-ej1-f70.google.com with SMTP id jl8-20020a17090775c8b02904db50c87233so1829057ejc.16
        for <bpf@vger.kernel.org>; Tue, 06 Jul 2021 08:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=T2UPWIhoK4ShiSSNDhtKtJnetsTjyJJ0DdRImI232kk=;
        b=ZvjMRpj57kCBof+trhhkf6dwXvivdm38ABVb28iidhNNA4DXm04z209CtSxHk9VlbJ
         ebOEi5vr4M8Mxd2M0JXgwAzs2t8U3mTGmaTuZkRkU2ba6c8vMKl7wM5DrfdnInjKxWw0
         +bULw5ZcneOqYDtA5SBfYTCxaKYTYgV7NJSGu9vqO8h6L2RxKxqkDLUkcUZxs64vVUCF
         JlMpqLp+i7woi6UvAG2H58mjrxg2wUImUJaabSos/JxmGKzlVCRneQwoHCx05DipkYg8
         an5RkBO8+pXQXCEYrKCID+2hpX9HG3VFBccUvTWryYwV3Qoihx8vL7xtYynHq57B3FKG
         8njw==
X-Gm-Message-State: AOAM531oWUniKoOcyuqrFfe11OAhjW0BhDJqXjyhb4vakr7yQK+G0qMG
        u/Vlx9ilQl6ZBJch3DsuA9MshSIp687XLybRYHGDnIAPyHqqJSkO4FIuZw5D85XwedMITsI4s/n
        vcSy50J6P+3ds
X-Received: by 2002:aa7:cb9a:: with SMTP id r26mr24500686edt.78.1625586265568;
        Tue, 06 Jul 2021 08:44:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPF7lxCausficd6gDWkOjfLws4DLxZyxgKlLO4VsiakVEoC31B2IBvVRy4S+HfLm4Hhcdi1w==
X-Received: by 2002:aa7:cb9a:: with SMTP id r26mr24500629edt.78.1625586265180;
        Tue, 06 Jul 2021 08:44:25 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id j22sm6119469ejt.11.2021.07.06.08.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 08:44:24 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E8C7118072E; Tue,  6 Jul 2021 17:44:22 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     "luwei (O)" <luwei32@huawei.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v4 bpf-next 1/9] bpf: Introduce bpf timers.
In-Reply-To: <bcdccd37-6372-859f-824e-c96250361904@huawei.com>
References: <20210701192044.78034-1-alexei.starovoitov@gmail.com>
 <20210701192044.78034-2-alexei.starovoitov@gmail.com>
 <bcdccd37-6372-859f-824e-c96250361904@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 06 Jul 2021 17:44:22 +0200
Message-ID: <87eecbxx9l.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"luwei (O)" <luwei32@huawei.com> writes:

> =E5=9C=A8 2021/7/2 3:20 AM, Alexei Starovoitov =E5=86=99=E9=81=93:
>> From: Alexei Starovoitov <ast@kernel.org>
>>
>> Introduce 'struct bpf_timer { __u64 :64; __u64 :64; };' that can be embe=
dded
>> in hash/array/lru maps as a regular field and helpers to operate on it:
>>
>> // Initialize the timer.
>> // First 4 bits of 'flags' specify clockid.
>> // Only CLOCK_MONOTONIC, CLOCK_REALTIME, CLOCK_BOOTTIME are allowed.
>> long bpf_timer_init(struct bpf_timer *timer, struct bpf_map *map, int fl=
ags);
>>
>> // Configure the timer to call 'callback_fn' static function.
>> long bpf_timer_set_callback(struct bpf_timer *timer, void *callback_fn);
>>
>> // Arm the timer to expire 'nsec' nanoseconds from the current time.
>> long bpf_timer_start(struct bpf_timer *timer, u64 nsec, u64 flags);
>>
>> // Cancel the timer and wait for callback_fn to finish if it was running.
>> long bpf_timer_cancel(struct bpf_timer *timer);
>>
> [...]
>> +static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
>> +{
>> +	struct bpf_hrtimer *t =3D container_of(hrtimer, struct bpf_hrtimer, ti=
mer);
>> +	struct bpf_map *map =3D t->map;
>> +	void *value =3D t->value;
>> +	struct bpf_timer_kern *timer =3D value + map->timer_off;
>> +	struct bpf_prog *prog;
>> +	void *callback_fn;
>> +	void *key;
>> +	u32 idx;
>> +	int ret;
>> +
>> +	/* The triple underscore bpf_spin_lock is a direct call
>> +	 * to BPF_CALL_1(bpf_spin_lock) which does irqsave.
>> +	 */
>> +	____bpf_spin_lock(&timer->lock);
>> +	/* callback_fn and prog need to match. They're updated together
>> +	 * and have to be read under lock.
>> +	 */
>> +	prog =3D t->prog;
>> +	callback_fn =3D t->callback_fn;
>> +
>> +	/* wrap bpf subprog invocation with prog->refcnt++ and -- to make
>> +	 * sure that refcnt doesn't become zero when subprog is executing.
>> +	 * Do it under lock to make sure that bpf_timer_start doesn't drop
>> +	 * prev prog refcnt to zero before timer_cb has a chance to bump it.
>> +	 */
>> +	bpf_prog_inc(prog);
>> +	____bpf_spin_unlock(&timer->lock);
>> +
>> +	/* bpf_timer_cb() runs in hrtimer_run_softirq. It doesn't migrate and
>> +	 * cannot be preempted by another bpf_timer_cb() on the same cpu.
>> +	 * Remember the timer this callback is servicing to prevent
>> +	 * deadlock if callback_fn() calls bpf_timer_cancel() on the same time=
r.
>> +	 */
>> +	this_cpu_write(hrtimer_running, t);
>> +	if (map->map_type =3D=3D BPF_MAP_TYPE_ARRAY) {
>> +		struct bpf_array *array =3D container_of(map, struct bpf_array, map);
>> +
>> +		/* compute the key */
>> +		idx =3D ((char *)value - array->value) / array->elem_size;
>> +		key =3D &idx;
>> +	} else { /* hash or lru */
>> +		key =3D value - round_up(map->key_size, 8);
>> +	}
>> +
>> +	ret =3D BPF_CAST_CALL(callback_fn)((u64)(long)map,
>> +					 (u64)(long)key,
>> +					 (u64)(long)value, 0, 0);
>> +	WARN_ON(ret !=3D 0); /* Next patch moves this check into the verifier =
*/
>> +	bpf_prog_put(prog);
>> +
>> +	this_cpu_write(hrtimer_running, NULL);
>> +	return HRTIMER_NORESTART;
>> +}
>> +
> Your patch is awesome, and I tried your example and it works, my=20
> call_back() is called after a certained time.=C2=A0 But=C2=A0 I am confue=
d that=20
> the bpf_timer_cb() function only returns HRTIMER_NORESTART,
>
> how to trigger a periodic task, that means I want to call my call_back()=
=20
> periodically, not just for one time ?

The callback just needs to reschedule itself by calling
bpf_timer_start() again before exiting... :)

-Toke

