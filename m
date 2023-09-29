Return-Path: <bpf+bounces-11110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E736A7B3639
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 17:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id E59451C2097A
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 15:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACC2516E7;
	Fri, 29 Sep 2023 15:01:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8C34122F;
	Fri, 29 Sep 2023 15:00:58 +0000 (UTC)
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F319F9;
	Fri, 29 Sep 2023 08:00:56 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:53548)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1qmEz8-007D2d-PZ; Fri, 29 Sep 2023 09:00:54 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:40164 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1qmEz7-00H1Pg-Mc; Fri, 29 Sep 2023 09:00:54 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
  netdev@vger.kernel.org,
  bpf@vger.kernel.org,  David Ahern <dsahern@kernel.org>,  Christian
 Brauner <brauner@kernel.org>
References: <87a5t68zvw.fsf@toke.dk>
	<2aa087b5-cbcf-e736-00d4-d962a9deda75@6wind.com>
Date: Fri, 29 Sep 2023 10:00:31 -0500
In-Reply-To: <2aa087b5-cbcf-e736-00d4-d962a9deda75@6wind.com> (Nicolas
	Dichtel's message of "Thu, 28 Sep 2023 11:54:23 +0200")
Message-ID: <87h6ndausw.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1qmEz7-00H1Pg-Mc;;;mid=<87h6ndausw.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19i61uUz5S+JYlKIWRx48DML114NPDRlpM=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Nicolas Dichtel <nicolas.dichtel@6wind.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 531 ms - load_scoreonly_sql: 0.09 (0.0%),
	signal_user_changed: 11 (2.0%), b_tie_ro: 9 (1.7%), parse: 1.42 (0.3%),
	 extract_message_metadata: 14 (2.6%), get_uri_detail_list: 2.2 (0.4%),
	tests_pri_-2000: 5 (1.0%), tests_pri_-1000: 2.7 (0.5%),
	tests_pri_-950: 1.31 (0.2%), tests_pri_-900: 1.05 (0.2%),
	tests_pri_-200: 0.85 (0.2%), tests_pri_-100: 3.9 (0.7%),
	tests_pri_-90: 148 (27.9%), check_bayes: 145 (27.3%), b_tokenize: 9
	(1.6%), b_tok_get_all: 8 (1.5%), b_comp_prob: 2.8 (0.5%),
	b_tok_touch_all: 121 (22.9%), b_finish: 0.93 (0.2%), tests_pri_0: 323
	(60.8%), check_dkim_signature: 0.75 (0.1%), check_dkim_adsp: 13 (2.5%),
	 poll_dns_idle: 0.06 (0.0%), tests_pri_10: 1.95 (0.4%), tests_pri_500:
	13 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: Persisting mounts between 'ip netns' invocations
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Nicolas Dichtel <nicolas.dichtel@6wind.com> writes:

> + Eric
>
> Le 28/09/2023 =C3=A0 10:29, Toke H=C3=B8iland-J=C3=B8rgensen a =C3=A9crit=
=C2=A0:
>> Hi everyone
>>=20
>> I recently ran into this problem again, and so I figured I'd ask if
>> anyone has any good idea how to solve it:
>>=20
>> When running a command through 'ip netns exec', iproute2 will
>> "helpfully" create a new mount namespace and remount /sys inside it,
>> AFAICT to make sure /sys/class/net/* refers to the right devices inside
>> the namespace. This makes sense, but unfortunately it has the side
>> effect that no mount commands executed inside the ns persist. In
>> particular, this makes it difficult to work with bpffs; even when
>> mounting a bpffs inside the ns, it will disappear along with the
>> namespace as soon as the process exits.
>>=20
>> To illustrate:
>>=20
>> # ip netns exec <nsname> bpftool map pin id 2 /sys/fs/bpf/mymap
>> # ip netns exec <nsname> ls /sys/fs/bpf
>> <nothing>
>>=20
>> This happens because namespaces are cleaned up as soon as they have no
>> processes, unless they are persisted by some other means. For the
>> network namespace itself, iproute2 will bind mount /proc/self/ns/net to
>> /var/run/netns/<nsname> (in the root mount namespace) to persist the
>> namespace. I tried implementing something similar for the mount
>> namespace, but that doesn't work; I can't manually bind mount the 'mnt'
>> ns reference either:
>>=20
>> # mount -o bind /proc/104444/ns/mnt /var/run/netns/mnt/testns
>> mount: /run/netns/mnt/testns: wrong fs type, bad option, bad superblock =
on /proc/104444/ns/mnt, missing codepage or helper program, or other error.
>>        dmesg(1) may have more information after failed mount system call.
>>=20
>> When running strace on that mount command, it seems the move_mount()
>> syscall returns EINVAL, which, AFAICT, is because the mount namespace
>> file references itself as its namespace, which means it can't be
>> bind-mounted into the containing mount namespace.
>>=20
>> So, my question is, how to overcome this limitation? I know it's
>> possible to get a reference to the namespace of a running process, but
>> there is no guarantee there is any processes running inside the
>> namespace (hence the persisting bind mount for the netns). So is there
>> some other way to persist the mount namespace reference, so we can pick
>> it back up on the next 'ip netns' invocation?
>>=20
>> Hoping someone has a good idea :)
> We ran into similar problems. The only solution we found was to use nsent=
er
> instead of 'ip netns exec'.
>
> To be able to bind mount a mount namespace on a file, the directory of th=
is file
> should be private. For example:
>
> mkdir -p /run/foo
> mount --make-rshared /
> mount --bind /run/foo /run/foo
> mount --make-private /run/foo
> touch /run/foo/ns
> unshare --mount --propagation=3Dslave -- sh -c 'yes $$ 2>/dev/null' | {
>         read -r pid &&
>         mount --bind /proc/$pid/ns/mnt /run/foo/ns
> }
> nsenter --mount=3D/run/foo/ns ls /
>
> But this doesn't work under 'ip netns exec'.

My goal in writing "ip netns exec" was to be a compatibility layer for
applications that are not aware of multiple network namespaces.

My gut says to recommend you stop using the compatibility shim and have
your applications become network namespace aware (as it appears the
already partially are).

Beyond that I can not give advice unless I understand why you are
attempting to persist mounts that depend upon the network namespace.

Eric

