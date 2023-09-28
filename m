Return-Path: <bpf+bounces-11025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4227B17E6
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 11:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E257C282228
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 09:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13400347C3;
	Thu, 28 Sep 2023 09:54:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DB92E65C
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 09:54:29 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF7418F
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 02:54:27 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50567477b29so376677e87.3
        for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 02:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1695894865; x=1696499665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ylEtz/bYueZxejCB/F694KJ9CVGVyhXeJow5uwEpCiM=;
        b=Ez362pQ32wCN0UPp7hWeBwPcliV8wn4g13T7BTWYW2CUihCArFJ99aieGzDvB800Wt
         Lnh090GWzcf5syxnODuJwlrVojg8mizkixkbs7W6ZNnN8cDlV794WA/7sEzpNmoGqw9S
         H91xJryRK7sRHslKs76WzGC9zaUfyZqtG9EDE+zy2A97jSucmbU3I9q9d5W2JF6kLtzP
         jjw7axbqmW5SUKpgJhOLj5x+yjeqFr6Es8gPN9R/pFn+4fElhmn9/4gPXxglBQSbpPT1
         NqRdZf15gi6lp4i0xaQRWyN+z89ar+Jzgx6tv1T/+agkAzVJrzAaFcboCDlpuNRuoiVt
         vuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695894865; x=1696499665;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylEtz/bYueZxejCB/F694KJ9CVGVyhXeJow5uwEpCiM=;
        b=cB/PFkv1stRXWDbu1I76hwkIUqOJ0ABpdW5FpCOvFLXoQArqgbS7s8ywf80wnQJfAY
         MRxfsg8HuR7GH/lXKnnt5U0cVYuBbivTXPmVzxktGZEqCPythZNJSjtiGz+/E64tcuFL
         FDfMZb1Ph0COsJX8LewV2dtzad2Zer/lTQwgdo7jQZc3HyHCKMzdTDLeDePdviHEOB7K
         kperdgzfVnxWJX0IfLSX5Y2osLL73/4bnGjueBFUi3dyISCCqUPf7s5Kn+5v92+jFieD
         24OSM4XiC5DMBkzppZQrJaaTiEJYlpNlghmXx0LIrr7EhGS4VAbA56ULmgN9kOuKI9xM
         v1uA==
X-Gm-Message-State: AOJu0YxyIkIEsa+PKAdBrcKiu1ML5JLDjw07XskFk5Cqb9CxDKSTaerg
	HKQEIn25qHqYQABmocUPtxZ5fw==
X-Google-Smtp-Source: AGHT+IGsiyWrA4zvzPVrBFultVpUGGy6vz7/iG0Wkll9UKzh5Be6zEpsoGMP2HBAneIccRmWnOh3Ww==
X-Received: by 2002:a05:6512:55c:b0:4ff:7f7f:22e7 with SMTP id h28-20020a056512055c00b004ff7f7f22e7mr619089lfl.17.1695894865181;
        Thu, 28 Sep 2023 02:54:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:ba8a:d91e:ca02:910b? ([2a01:e0a:b41:c160:ba8a:d91e:ca02:910b])
        by smtp.gmail.com with ESMTPSA id t3-20020a5d5343000000b0030ae53550f5sm18891354wrv.51.2023.09.28.02.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 02:54:24 -0700 (PDT)
Message-ID: <2aa087b5-cbcf-e736-00d4-d962a9deda75@6wind.com>
Date: Thu, 28 Sep 2023 11:54:23 +0200
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
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 "Eric W. Biederman" <ebiederm@xmission.com>
Cc: David Ahern <dsahern@kernel.org>, Christian Brauner <brauner@kernel.org>
References: <87a5t68zvw.fsf@toke.dk>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <87a5t68zvw.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

+ Eric

Le 28/09/2023 à 10:29, Toke Høiland-Jørgensen a écrit :
> Hi everyone
> 
> I recently ran into this problem again, and so I figured I'd ask if
> anyone has any good idea how to solve it:
> 
> When running a command through 'ip netns exec', iproute2 will
> "helpfully" create a new mount namespace and remount /sys inside it,
> AFAICT to make sure /sys/class/net/* refers to the right devices inside
> the namespace. This makes sense, but unfortunately it has the side
> effect that no mount commands executed inside the ns persist. In
> particular, this makes it difficult to work with bpffs; even when
> mounting a bpffs inside the ns, it will disappear along with the
> namespace as soon as the process exits.
> 
> To illustrate:
> 
> # ip netns exec <nsname> bpftool map pin id 2 /sys/fs/bpf/mymap
> # ip netns exec <nsname> ls /sys/fs/bpf
> <nothing>
> 
> This happens because namespaces are cleaned up as soon as they have no
> processes, unless they are persisted by some other means. For the
> network namespace itself, iproute2 will bind mount /proc/self/ns/net to
> /var/run/netns/<nsname> (in the root mount namespace) to persist the
> namespace. I tried implementing something similar for the mount
> namespace, but that doesn't work; I can't manually bind mount the 'mnt'
> ns reference either:
> 
> # mount -o bind /proc/104444/ns/mnt /var/run/netns/mnt/testns
> mount: /run/netns/mnt/testns: wrong fs type, bad option, bad superblock on /proc/104444/ns/mnt, missing codepage or helper program, or other error.
>        dmesg(1) may have more information after failed mount system call.
> 
> When running strace on that mount command, it seems the move_mount()
> syscall returns EINVAL, which, AFAICT, is because the mount namespace
> file references itself as its namespace, which means it can't be
> bind-mounted into the containing mount namespace.
> 
> So, my question is, how to overcome this limitation? I know it's
> possible to get a reference to the namespace of a running process, but
> there is no guarantee there is any processes running inside the
> namespace (hence the persisting bind mount for the netns). So is there
> some other way to persist the mount namespace reference, so we can pick
> it back up on the next 'ip netns' invocation?
> 
> Hoping someone has a good idea :)
We ran into similar problems. The only solution we found was to use nsenter
instead of 'ip netns exec'.

To be able to bind mount a mount namespace on a file, the directory of this file
should be private. For example:

mkdir -p /run/foo
mount --make-rshared /
mount --bind /run/foo /run/foo
mount --make-private /run/foo
touch /run/foo/ns
unshare --mount --propagation=slave -- sh -c 'yes $$ 2>/dev/null' | {
        read -r pid &&
        mount --bind /proc/$pid/ns/mnt /run/foo/ns
}
nsenter --mount=/run/foo/ns ls /

But this doesn't work under 'ip netns exec'.


Regards,
Nicolas

