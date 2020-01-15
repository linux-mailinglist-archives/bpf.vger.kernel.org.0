Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D17E313C139
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2020 13:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgAOMlZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jan 2020 07:41:25 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40135 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgAOMlZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jan 2020 07:41:25 -0500
Received: by mail-lj1-f193.google.com with SMTP id u1so18382023ljk.7
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2020 04:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=hDEaIYv8oHK5XCkZ/NcUnB5EfEhHDTzkrgkJdoO1LTc=;
        b=O/WaBccO0m2mZzmU9Ar92NvJbM2FXZhoR4S+6AkVrjY7b1Dv19NipwHSfZCsMtGONI
         m7k0v54wnRlmJqWYELZDjH753cij9EhYvE6hisEPuFn411avJ6qb6UgiQE8kwlUuVBrh
         YHvzIn3EJ0dvuwl9f0POx5jT8MRthwdB1sU8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=hDEaIYv8oHK5XCkZ/NcUnB5EfEhHDTzkrgkJdoO1LTc=;
        b=LrL9Y/DU5YfH4UUFaGJaLiTjKrBbo0GF28+aYFGZYJ9QbfRiHYc3Et8xe+x3tqX3n9
         jeVu9ZiRxXW5blVagSfU0yVQPVgMzPHMwYcMP0VuSNu891zAk1u3x/Ku41vzULuF2bq5
         Q+rcUibKFFm829eLQT3dnznEkXXUSRaUcs+O+2dqGDrysret6uc7sh4DdSZVGB4cOPdY
         dekkVrLKcF8RrB+ntVY58hxRTqisQUE0FC5lv2NwOYWGsIEfH6q8fAwV+WnY99iL/zoK
         5E9mH+rDEcKu0tme2gjP1c2Rkk3LAn9ZFkPqoI1tBj1w6cVSCXC3iFMUbOLNDwGqiiU/
         ZQ/Q==
X-Gm-Message-State: APjAAAWkFkU6TIFDLL5E6IlV2NxzVKOs9v7vdYVSaffh7L7aOo3dBa69
        7NFK605GTqv1+TzLvcoiTg22tQ==
X-Google-Smtp-Source: APXvYqyF3d9w+FnEma3M1fwg8sPVtrznM/lTdwMgKU04gNeZWWcqeYWgg4t4scssD5wjzTSMIGxZPQ==
X-Received: by 2002:a2e:3609:: with SMTP id d9mr1541486lja.188.1579092082531;
        Wed, 15 Jan 2020 04:41:22 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id l12sm9108588lji.52.2020.01.15.04.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 04:41:21 -0800 (PST)
References: <20200110105027.257877-1-jakub@cloudflare.com> <20200110105027.257877-10-jakub@cloudflare.com> <20200113234541.sru7domciovzijnx@kafai-mbp.dhcp.thefacebook.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Martin Lau <kafai@fb.com>
Cc:     "bpf\@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "kernel-team\@cloudflare.com" <kernel-team@cloudflare.com>,
        Eric Dumazet <edumazet@google.com>,
        "John Fastabend" <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: Re: [PATCH bpf-next v2 09/11] bpf: Allow selecting reuseport socket from a SOCKMAP
In-reply-to: <20200113234541.sru7domciovzijnx@kafai-mbp.dhcp.thefacebook.com>
Date:   Wed, 15 Jan 2020 13:41:21 +0100
Message-ID: <878sm8sxhq.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 14, 2020 at 12:45 AM CET, Martin Lau wrote:
> On Fri, Jan 10, 2020 at 11:50:25AM +0100, Jakub Sitnicki wrote:
>> SOCKMAP now supports storing references to listening sockets. Nothing keeps
>> us from using it as an array of sockets to select from in SK_REUSEPORT
>> programs.
>>
>> Whitelist the map type with the BPF helper for selecting socket.
>>
>> The restriction that the socket has to be a member of a reuseport group
>> still applies. Socket from a SOCKMAP that does not have sk_reuseport_cb set
>> is not a valid target and we signal it with -EINVAL.
>>
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>>  kernel/bpf/verifier.c |  6 ++++--
>>  net/core/filter.c     | 15 ++++++++++-----
>>  2 files changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index f5af759a8a5f..0ee5f1594b5c 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -3697,7 +3697,8 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
>>  		if (func_id != BPF_FUNC_sk_redirect_map &&
>>  		    func_id != BPF_FUNC_sock_map_update &&
>>  		    func_id != BPF_FUNC_map_delete_elem &&
>> -		    func_id != BPF_FUNC_msg_redirect_map)
>> +		    func_id != BPF_FUNC_msg_redirect_map &&
>> +		    func_id != BPF_FUNC_sk_select_reuseport)
>>  			goto error;
>>  		break;
>>  	case BPF_MAP_TYPE_SOCKHASH:
>> @@ -3778,7 +3779,8 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
>>  			goto error;
>>  		break;
>>  	case BPF_FUNC_sk_select_reuseport:
>> -		if (map->map_type != BPF_MAP_TYPE_REUSEPORT_SOCKARRAY)
>> +		if (map->map_type != BPF_MAP_TYPE_REUSEPORT_SOCKARRAY &&
>> +		    map->map_type != BPF_MAP_TYPE_SOCKMAP)
>>  			goto error;
>>  		break;
>>  	case BPF_FUNC_map_peek_elem:
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index a702761ef369..c79c62a54167 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -8677,6 +8677,7 @@ struct sock *bpf_run_sk_reuseport(struct sock_reuseport *reuse, struct sock *sk,
>>  BPF_CALL_4(sk_select_reuseport, struct sk_reuseport_kern *, reuse_kern,
>>  	   struct bpf_map *, map, void *, key, u32, flags)
>>  {
>> +	bool is_sockarray = map->map_type == BPF_MAP_TYPE_REUSEPORT_SOCKARRAY;
>>  	struct sock_reuseport *reuse;
>>  	struct sock *selected_sk;
>>
>> @@ -8685,12 +8686,16 @@ BPF_CALL_4(sk_select_reuseport, struct sk_reuseport_kern *, reuse_kern,
>>  		return -ENOENT;
>>
>>  	reuse = rcu_dereference(selected_sk->sk_reuseport_cb);
>> -	if (!reuse)
>> -		/* selected_sk is unhashed (e.g. by close()) after the
>> -		 * above map_lookup_elem().  Treat selected_sk has already
>> -		 * been removed from the map.
>> +	if (!reuse) {
>> +		/* reuseport_array has only sk with non NULL sk_reuseport_cb.
>> +		 * The only (!reuse) case here is - the sk has already been
>> +		 * unhashed (e.g. by close()), so treat it as -ENOENT.
>> +		 *
>> +		 * Other maps (e.g. sock_map) do not provide this guarantee and
>> +		 * the sk may never be in the reuseport group to begin with.
>>  		 */
>> -		return -ENOENT;
>> +		return is_sockarray ? -ENOENT : -EINVAL;
>> +	}
>>
>>  	if (unlikely(reuse->reuseport_id != reuse_kern->reuseport_id)) {
> I guess the later testing patch passed is because reuseport_id is init to 0.
>
> Note that in reuseport_array, reuseport_get_id() is called at update_elem() to
> init the reuse->reuseport_id.  It was done there because reuseport_array
> was the only one requiring reuseport_id.  It is to ensure the bpf_prog
> cannot accidentally use a sk from another reuseport-group.
>
> The same has to be done in patch 5 or may be considering to
> move it to reuseport_alloc() itself.

I see what you're saying.

With these patches, it is possible to redirect connections across
reuseport groups with reuseport BPF and sockmap. While it should be
prohibited to be consistent with sockarray. Redirect helper should
return an error.

Will try to pull up reuseport_id initialization to reuseport_alloc(),
and add a test for a sockmap with two listening sockets that belong to
different reuseport groups.

Thanks for catching this bug.
