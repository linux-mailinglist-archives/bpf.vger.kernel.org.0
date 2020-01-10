Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C787136E4C
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2020 14:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgAJNkY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jan 2020 08:40:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36356 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbgAJNkX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jan 2020 08:40:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so1861773wru.3
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2020 05:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=5oUcV86C7JSKtfppsGNQxdaoGiUUdDpnfFPB5wLrxXo=;
        b=kipYCdJUBW7L3pVnHxGoxNxk1mBpQdgi5fLW30e0Ue29wGwfAb+eGmeJpRkSoNEGdu
         FJulPgHPqOl3gWCyy7eH9Ap4CDSvTwGbezEyTZTZRuu+BF5d3tZmE7X6rwN+9QolpV8N
         WSfbIWwW7fFtnZg1VZMRox5e3+/BrKx9VmfmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=5oUcV86C7JSKtfppsGNQxdaoGiUUdDpnfFPB5wLrxXo=;
        b=V5sqehU27IDxaG7Po7ebyEg3Ss89e1mYwNusXk1aKX/6B1kqePthBHaKXWva3WBHVz
         ulqK651EKWtjwqDaOKBZr6R3TK0HEY3tHSPo+OP7kpY9PerjGDR2Ni0MMP+eC+Px+csQ
         BCdMnoiZR+l/wgWCWc4TMmO6sev/b8FakuSUb3LaPb3YVrkcIWY3Hw7JxX8A350u1z8j
         L7pY5DHj9TQiKypl8oPBxa/LioSVrpJTWDqFABOVOWoaprCb4fvxK5dwgP0irVNxf+Ce
         WOCj77/NtefaDE9CcPcPO0PCdDOYpe4etZn8+zoryRGjcpdo+hKNBoc9xoIKlMVf6p0U
         J8Gg==
X-Gm-Message-State: APjAAAUcGjOiKOf8eKawFnEMQkVmIhLKhvztXm8nofQNx5X08f+rfVrQ
        qYi5wQy9clkpZ2LLGUI9WRWwTg==
X-Google-Smtp-Source: APXvYqwlnrWya14IiTSuRAHlp6HurNXuYl+C/QNtJ82vPYJiA3uB8jfjv4gCpuymNyp47hNglqCRhw==
X-Received: by 2002:adf:ed83:: with SMTP id c3mr3572130wro.51.1578663621578;
        Fri, 10 Jan 2020 05:40:21 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id d14sm2351222wru.9.2020.01.10.05.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 05:40:20 -0800 (PST)
References: <157851776348.1732.12600714815781177085.stgit@ubuntu3-kvm2> <157851808101.1732.11616068811837364406.stgit@ubuntu3-kvm2> <87tv54syv8.fsf@cloudflare.com> <5e1799a913185_35982ae92e9d45bcc9@john-XPS-13-9370.notmuch>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Subject: Re: [bpf PATCH 3/9] bpf: sockmap/tls, push write_space updates through ulp updates
In-reply-to: <5e1799a913185_35982ae92e9d45bcc9@john-XPS-13-9370.notmuch>
Date:   Fri, 10 Jan 2020 14:40:20 +0100
Message-ID: <87sgknsa4b.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 09, 2020 at 10:22 PM CET, John Fastabend wrote:
> Jakub Sitnicki wrote:
>> On Wed, Jan 08, 2020 at 10:14 PM CET, John Fastabend wrote:
>> > When sockmap sock with TLS enabled is removed we cleanup bpf/psock state
>> > and call tcp_update_ulp() to push updates to TLS ULP on top. However, we
>> > don't push the write_space callback up and instead simply overwrite the
>> > op with the psock stored previous op. This may or may not be correct so
>> > to ensure we don't overwrite the TLS write space hook pass this field to
>> > the ULP and have it fixup the ctx.
>> >
>> > This completes a previous fix that pushed the ops through to the ULP
>> > but at the time missed doing this for write_space, presumably because
>> > write_space TLS hook was added around the same time.
>> >
>> > Fixes: 95fa145479fbc ("bpf: sockmap/tls, close can race with map free")
>> > Signed-off-by: John Fastabend <john.fastabend@gmail.com>
>> > ---
>> >  include/linux/skmsg.h |   12 ++++++++----
>> >  include/net/tcp.h     |    6 ++++--
>> >  net/ipv4/tcp_ulp.c    |    6 ++++--
>> >  net/tls/tls_main.c    |   10 +++++++---
>> >  4 files changed, 23 insertions(+), 11 deletions(-)
>> >
>> > diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
>> > index b6afe01f8592..14d61bba0b79 100644
>> > --- a/include/linux/skmsg.h
>> > +++ b/include/linux/skmsg.h
>> > @@ -359,17 +359,21 @@ static inline void sk_psock_restore_proto(struct sock *sk,
>> >  					  struct sk_psock *psock)
>> >  {
>> >  	sk->sk_prot->unhash = psock->saved_unhash;
>> > -	sk->sk_write_space = psock->saved_write_space;
>> >
>> >  	if (psock->sk_proto) {
>> >  		struct inet_connection_sock *icsk = inet_csk(sk);
>> >  		bool has_ulp = !!icsk->icsk_ulp_data;
>> >
>> > -		if (has_ulp)
>> > -			tcp_update_ulp(sk, psock->sk_proto);
>> > -		else
>> > +		if (has_ulp) {
>> > +			tcp_update_ulp(sk, psock->sk_proto,
>> > +				       psock->saved_write_space);
>> > +		} else {
>> >  			sk->sk_prot = psock->sk_proto;
>> > +			sk->sk_write_space = psock->saved_write_space;
>> > +		}
>>
>> I'm wondering if we need the above fallback branch for no-ULP case?
>> tcp_update_ulp repeats the ULP check and has the same fallback. Perhaps
>> it can be reduced to:
>>
>> 	if (psock->sk_proto) {
>> 		tcp_update_ulp(sk, psock->sk_proto, psock->saved_write_space);
>> 		psock->sk_proto = NULL;
>> 	} else {
>> 		sk->sk_write_space = psock->saved_write_space;
>> 	}
>
> Yeah that is a bit nicer. How about pushing it for bpf-next? I'm not
> sure its needed for bpf and the patch I pushed is the minimal change
> needed for the fix and pushes the saved_write_space around.

Yeah, this is bpf-next material.

>> Then there's the question if it's okay to leave psock->sk_proto set and
>> potentially restore it more than once? Reading tls_update, the only user
>> ULP 'update' callback, it looks fine.
>>
>> Can sk_psock_restore_proto be as simple as:
>>
>> static inline void sk_psock_restore_proto(struct sock *sk,
>> 					  struct sk_psock *psock)
>> {
>> 	tcp_update_ulp(sk, psock->sk_proto, psock->saved_write_space);
>> }
>>
>> ... or am I missing something?
>
> I think that is good. bpf-next?

Great, I needed to confirm my thinking.

>> Asking becuase I have a patch [0] like this in the queue and haven't
>> seen issues with it during testing.
>
> +1 Want to push it after we sort out this series?

I've actually pushed it earlier today with next iteration of "Extend
SOCKMAP to store listening sockets" to collect feedback [0]. I will
adapt it once it shows up in bpf-next (or split it out and submit
separately).

-jkbs

[0] https://lore.kernel.org/bpf/20200110105027.257877-1-jakub@cloudflare.com/
