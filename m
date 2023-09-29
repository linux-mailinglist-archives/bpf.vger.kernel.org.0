Return-Path: <bpf+bounces-11099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 070327B2DC7
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 10:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 17624282B12
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 08:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4061FBE1;
	Fri, 29 Sep 2023 08:26:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC234F9E8
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 08:26:37 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C02B1A5
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 01:26:35 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9b27bc8b65eso1229883066b.0
        for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 01:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1695975994; x=1696580794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=23yH0BNZzwfYBudqKllSnoXRGS73pAdr6tfQ7LisAW4=;
        b=hTFcJHR2bEWT5we7Jqx420cRgwnT+hmnmdhF7wTKGTNGynDp+YoC98x189PN1EIg9S
         6hKONmFrWLQB+oSoTBbTxgzzzr/SNYmynfP1ZB0hk0WMwuhn+q5APsomz8zXFVeMYMz+
         zsCN7UziYG7WQeR/q3x9UZnpGb6y/3xA4tp7AyLhyuWyXSMcAWPHlM7c3EBvyf9w02JN
         UjLXA5lsg1PPaqdiuC67uJQjz8ApKbnl1+UO1xIrTxSQlk4c7XYrMa6jLsL/gACabrcS
         jFv7ZZ6BkQPm1UPYQJStFDkRIOhFAU+TYVaegpUjh43itYejcbJhWe2F6tcg9sTvp6Hk
         SwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695975994; x=1696580794;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23yH0BNZzwfYBudqKllSnoXRGS73pAdr6tfQ7LisAW4=;
        b=wpdP2n24ZGNRGVv/9JZ6MWDy+zugpS+aF9gqLmhUf79cB1eVg8Ty4ZsKOwTRf3TqEi
         UutJQblIV77oQn+ULwLizuho1cbIahKYlIZWqxMK/f7nUhp05qS+fBfb2i4f4fWSEnDy
         M11I4gMhT5nKpCClumoG5jpBxF4ef00TV1uMHFF0nglMJgu1ShkEaEENLLX4GQV+HPT6
         XfkycIdoYYi9ZeMRI/AzfvmJn34Uio47k224Mw6m1/8rZxjiSGbuXaqPmFzmPJSivNM7
         p8yxfhpxeFjYpRAQ5sK/7eIM9I/XEU5kRgbRUHBJo728e8hG1QhfcZRzkt/CF0uR4Z0y
         5PnA==
X-Gm-Message-State: AOJu0YzY07PU7cdNbnuxIyUkjsTIBGVhuiUdGkOdKn98jwieIdUlU0oe
	P6X8c8B2Ni8D4PZ3TdFsjkeYAQ==
X-Google-Smtp-Source: AGHT+IG5c7ZLODhzgcjbTetb2Xpcq5dO0m5smUL0MHCHtHz/4AO0lfHplR/aNulH09soqJckpuP2xA==
X-Received: by 2002:a17:907:75cc:b0:9ae:654d:510e with SMTP id jl12-20020a17090775cc00b009ae654d510emr3126251ejc.5.1695975993924;
        Fri, 29 Sep 2023 01:26:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:a470:6c6:a6ee:941f? ([2a01:e0a:b41:c160:a470:6c6:a6ee:941f])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c4fce00b004065d67c3c9sm831851wmq.8.2023.09.29.01.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 01:26:33 -0700 (PDT)
Message-ID: <a68b135f-12ee-3c75-8b12-d039c9036d53@6wind.com>
Date: Fri, 29 Sep 2023 10:26:32 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: Persisting mounts between 'ip netns' invocations
Content-Language: en-US
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 Christian Brauner <brauner@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 "Eric W. Biederman" <ebiederm@xmission.com>, David Ahern <dsahern@kernel.org>
References: <87a5t68zvw.fsf@toke.dk>
 <2aa087b5-cbcf-e736-00d4-d962a9deda75@6wind.com>
 <20230928-geldbeschaffung-gekehrt-81ed7fba768d@brauner>
 <87il7ucg5z.fsf@toke.dk>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <87il7ucg5z.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Le 28/09/2023 à 20:21, Toke Høiland-Jørgensen a écrit :
> Christian Brauner <brauner@kernel.org> writes:
> 
>> On Thu, Sep 28, 2023 at 11:54:23AM +0200, Nicolas Dichtel wrote:
>>> + Eric
>>>
>>> Le 28/09/2023 à 10:29, Toke Høiland-Jørgensen a écrit :
>>>> Hi everyone
>>>>
>>>> I recently ran into this problem again, and so I figured I'd ask if
>>>> anyone has any good idea how to solve it:
>>>>
>>>> When running a command through 'ip netns exec', iproute2 will
>>>> "helpfully" create a new mount namespace and remount /sys inside it,
>>>> AFAICT to make sure /sys/class/net/* refers to the right devices inside
>>>> the namespace. This makes sense, but unfortunately it has the side
>>>> effect that no mount commands executed inside the ns persist. In
>>>> particular, this makes it difficult to work with bpffs; even when
>>>> mounting a bpffs inside the ns, it will disappear along with the
>>>> namespace as soon as the process exits.
>>>>
>>>> To illustrate:
>>>>
>>>> # ip netns exec <nsname> bpftool map pin id 2 /sys/fs/bpf/mymap
>>>> # ip netns exec <nsname> ls /sys/fs/bpf
>>>> <nothing>
>>>>
>>>> This happens because namespaces are cleaned up as soon as they have no
>>>> processes, unless they are persisted by some other means. For the
>>>> network namespace itself, iproute2 will bind mount /proc/self/ns/net to
>>>> /var/run/netns/<nsname> (in the root mount namespace) to persist the
>>>> namespace. I tried implementing something similar for the mount
>>>> namespace, but that doesn't work; I can't manually bind mount the 'mnt'
>>>> ns reference either:
>>>>
>>>> # mount -o bind /proc/104444/ns/mnt /var/run/netns/mnt/testns
>>>> mount: /run/netns/mnt/testns: wrong fs type, bad option, bad superblock on /proc/104444/ns/mnt, missing codepage or helper program, or other error.
>>>>        dmesg(1) may have more information after failed mount system call.
>>>>
>>>> When running strace on that mount command, it seems the move_mount()
>>>> syscall returns EINVAL, which, AFAICT, is because the mount namespace
>>>> file references itself as its namespace, which means it can't be
>>>> bind-mounted into the containing mount namespace.
>>>>
>>>> So, my question is, how to overcome this limitation? I know it's
>>>> possible to get a reference to the namespace of a running process, but
>>>> there is no guarantee there is any processes running inside the
>>>> namespace (hence the persisting bind mount for the netns). So is there
>>>> some other way to persist the mount namespace reference, so we can pick
>>>> it back up on the next 'ip netns' invocation?
>>>>
>>>> Hoping someone has a good idea :)
>>> We ran into similar problems. The only solution we found was to use nsenter
>>> instead of 'ip netns exec'.
>>>
>>> To be able to bind mount a mount namespace on a file, the directory of this file
>>> should be private. For example:
>>>
>>> mkdir -p /run/foo
>>> mount --make-rshared /
>>> mount --bind /run/foo /run/foo
>>> mount --make-private /run/foo
>>> touch /run/foo/ns
>>> unshare --mount --propagation=slave -- sh -c 'yes $$ 2>/dev/null' | {
>>>         read -r pid &&
>>>         mount --bind /proc/$pid/ns/mnt /run/foo/ns
>>> }
>>> nsenter --mount=/run/foo/ns ls /
>>>
>>> But this doesn't work under 'ip netns exec'.
>>
>> Afaiu, each ip netns exec invocation allocates a new mount namespace.
>> If you run multiple concurrent ip netns exec command and leave them
>> around then they all get a separate mount namespace. Not sure what the
>> design behind that was. So even if you could persist the mount namespace
>> of one there's still no way for ip netns exec to pick that up iiuc.
>>
>> So imho, the solution is to change ip netns exec to persist a mount
>> namespace and netns namespace pair. unshare does this easily via:
>>
>> sudo mkdir /run/mntns
>> sudo mount --bind /run/mntns /run/mntns
>> sudo mount --make-slave /run/mntns
>>
>> sudo mkdir /run/netns
>>
>> sudo touch /run/mntns/mnt1
>> sudo touch /run/netns/net1
>>
>> sudo unshare --mount=/run/mntns/mnt1 --net=/run/netns/net1 true
I fear that creating a new mount ns for each net ns will introduce more problems.

>>
>> So I'd probably patch iproute2.
> 
> Patching iproute2 is what I'm trying to do - sorry if that wasn't clear :)
> 
> However, I couldn't get it to work. I think it's probably because I was
> missing the bind-to-self/--make-slave dance on the containing folder, as
> Nicolas pointed out. Will play around with that a bit more, thanks for
> the pointers both of you!

The fundamental problem is that the remount of /sys should not be propagated to
the parent mount ns (and in fact the /etc remount also).
You will have to choose between 'propagating the new mount points to the parent
mount ns' and 'having the right view of /sys (ie the /sys corresponding to the
current netns)'.
Maybe this could be done via a new command, something like 'ip netns light-exec'
(which will be equivalent to 'nsenter --net=/run/netns/foo').

FWIW, here is a nice doc about mount subtleties:
https://www.kernel.org/doc/Documentation/filesystems/sharedsubtree.txt

Regards,
Nicolas

