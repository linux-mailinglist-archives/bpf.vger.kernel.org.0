Return-Path: <bpf+bounces-60201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB005AD3ED1
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 18:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FEFB178924
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 16:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BA823D287;
	Tue, 10 Jun 2025 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Zx+x9wFu"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717282397BF;
	Tue, 10 Jun 2025 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749572825; cv=none; b=eKVjsamkk5qFjDslw94mXUV5jpVPqjfh1M4pBzHB0nMmnM7nzY91Yj6faeevumpnay4aFmsN5KYAEnDk0Su/VS0Ml9xvYD9l5F9RBNs4N0iDyjenQxWy6eN7tgzGKCbn9a8+h4qJWLACKVjkf4xbqdfZ39KlHHcBsNJvaRQHeuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749572825; c=relaxed/simple;
	bh=pP870zDIb4r8/GKNFbLgcL7hSOEnmBLb98cd8Mk2W+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HC6LSAdDlseHSN2eA1NgrCS1miYBrS9RZh7iRIzcUJtGGtpYNvOadxyYfmwgbnCxTWxNingJzC7+uY82K/UiDBkWYwiWgCTqgco6AgMF1iWD5osjk4oQIgY2nksp9xzICN1V6UslXK00LoOOxI40AXR53TAJznify1RwA9nB8tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Zx+x9wFu; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=b5iUreELVegy9zHBLef9My826vz+Z0wQpOMG0HkMqNI=; b=Zx+x9wFup5B/cIpstJOFGa6QEN
	jfuaZeWYR0IOtDff9kcLB4pJg+INasINrLkTh3Wco6dpTAw2kWatYoFBa4vLkOYCa3OihE0d95eH8
	PZd202c3M06/f0tWaj+Y9mwAGRbBKwZyc0QaijNYJzBzRU5f85jO7kL9V+0xdSoCG7t1qRzFsBLKO
	qfk62JwPSZLN8qmIQFwpqbpJvX2Alt2mW6+oVETRwgEmlRAdFFk6wnmAuUSAXiiT95IsRoJuFMA1m
	6Nw8yg2jYgwgRkKm9nuSmPDfwW1SYO+Ih3deP3szcz4C3KhDKqL4HBA8HobgW7L7ssR7R9kUAV925
	/aOfXqiw==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uP1WD-00087U-1S;
	Tue, 10 Jun 2025 18:08:09 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1uP1WC-0000Vb-0M;
	Tue, 10 Jun 2025 18:08:08 +0200
Message-ID: <5016f963-90ea-4dfd-bf7b-c4a5565af70c@iogearbox.net>
Date: Tue, 10 Jun 2025 18:08:07 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: Fix RCU usage in
 bpf_get_cgroup_classid_curr helper
To: Charalampos Mitrodimas <charmitro@posteo.net>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Feng Yang <yangfeng@kylinos.cn>,
 Tejun Heo <tj@kernel.org>, Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 syzbot+b4169a1cfb945d2ed0ec@syzkaller.appspotmail.com
References: <20250608-rcu-fix-task_cls_state-v1-1-2a2025b4603b@posteo.net>
 <CAADnVQLxaxVpCaK90FfePOKMLpH=axaK3gDwVZLp0L1+fNxgtA@mail.gmail.com>
 <9eae82be-0900-44ea-b105-67fadc7d480d@iogearbox.net>
 <CAADnVQK_k4ReDwS_urGtJPQ1SXaHdrGWYxJGd-QK=tAn60p4vw@mail.gmail.com>
 <87wm9jy623.fsf@posteo.net>
 <CAADnVQ+mzrDH+8S=ddDCtyo6YUO4dUUsAS88Jza93pDQ2K3Bng@mail.gmail.com>
 <87tt4nzjbq.fsf@posteo.net>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <87tt4nzjbq.fsf@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27664/Tue Jun 10 10:41:04 2025)

On 6/10/25 5:51 PM, Charalampos Mitrodimas wrote:
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>> On Tue, Jun 10, 2025 at 8:23 AM Charalampos Mitrodimas
>> <charmitro@posteo.net> wrote:
>>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>>> On Tue, Jun 10, 2025 at 5:58 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>>> On 6/9/25 5:51 PM, Alexei Starovoitov wrote:
>>>>>> On Sun, Jun 8, 2025 at 8:35 AM Charalampos Mitrodimas
>>>>>> <charmitro@posteo.net> wrote:
>>>>>>>
>>>>>>> The commit ee971630f20f ("bpf: Allow some trace helpers for all prog
>>>>>>> types") made bpf_get_cgroup_classid_curr helper available to all BPF
>>>>>>> program types.  This helper used __task_get_classid() which calls
>>>>>>> task_cls_state() that requires rcu_read_lock_bh_held().
>>>>>>>
>>>>>>> This triggers an RCU warning when called from BPF syscall programs
>>>>>>> which run under rcu_read_lock_trace():
>>>>>>>
>>>>>>>     WARNING: suspicious RCU usage
>>>>>>>     6.15.0-rc4-syzkaller-g079e5c56a5c4 #0 Not tainted
>>>>>>>     -----------------------------
>>>>>>>     net/core/netclassid_cgroup.c:24 suspicious rcu_dereference_check() usage!
>>>>>>>
>>>>>>> Fix this by replacing __task_get_classid() with task_cls_classid()
>>>>>>> which handles RCU locking internally using regular rcu_read_lock() and
>>>>>>> is safe to call from any context.
>>>>>>>
>>>>>>> Reported-by: syzbot+b4169a1cfb945d2ed0ec@syzkaller.appspotmail.com
>>>>>>> Closes: https://syzkaller.appspot.com/bug?extid=b4169a1cfb945d2ed0ec
>>>>>>> Fixes: ee971630f20f ("bpf: Allow some trace helpers for all prog types")
>>>>>>> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
>>>>>>> ---
>>>>>>>    net/core/filter.c | 2 +-
>>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/net/core/filter.c b/net/core/filter.c
>>>>>>> index 30e7d36790883b29174654315738e93237e21dd0..3b3f81cf674dde7d2bd83488450edad4e129bdac 100644
>>>>>>> --- a/net/core/filter.c
>>>>>>> +++ b/net/core/filter.c
>>>>>>> @@ -3083,7 +3083,7 @@ static const struct bpf_func_proto bpf_msg_pop_data_proto = {
>>>>>>>    #ifdef CONFIG_CGROUP_NET_CLASSID
>>>>>>>    BPF_CALL_0(bpf_get_cgroup_classid_curr)
>>>>>>>    {
>>>>>>> -       return __task_get_classid(current);
>>>>>>> +       return task_cls_classid(current);
>>>>>>>    }
>>>>>>
>>>>>> Daniel added this helper in
>>>>>> commit 5a52ae4e32a6 ("bpf: Allow to retrieve cgroup v1 classid from v2 hooks")
>>>>>> with intention to use it from networking hooks.
>>>>>>
>>>>>> But task_cls_classid() has
>>>>>>           if (in_interrupt())
>>>>>>                   return 0;
>>>>>>
>>>>>> which will trigger in softirq and tc hooks.
>>>>>> So this might break Daniel's use case.
>>>>>
>>>>> Yeap, we cannot break tc(x) BPF programs. It probably makes sense to have
>>>>> a new helper implementation for the more generic, non-networking case which
>>>>> then internally uses task_cls_classid().
>>>>
>>>> Instead of forking the helper I think we can :
>>>> rcu_read_lock_bh_held() || rcu_read_lock_held()
>>>> in task_cls_state().
>>>
>>> I tested your suggestion with,
>>>
>>>    rcu_read_lock_bh_held() || rcu_read_lock_held()
>>>
>>> but it still triggers the RCU warning because BPF syscall programs use
>>> rcu_read_lock_trace().
>>>
>>> Adding rcu_read_lock_trace_held() fixes it functionally but triggers a
>>> checkpatch warning:
>>>
>>>    WARNING: use of RCU tasks trace is incorrect outside BPF or core RCU code
>>
>> It's safe to ignore checkpatch in this case.
> 
> If that is the case I'll move forward with this. It was my initial fix
> for this[1] anyway, but checkpatch made me change it.

Agree that one is better!

> [1]: https://github.com/charmitro/linux/commit/e5c42d49bfb967c3c35f536971f397492d2f46bf

Thanks,
Daniel

