Return-Path: <bpf+bounces-36109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49954942424
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 03:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4DF41F23521
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 01:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E27946F;
	Wed, 31 Jul 2024 01:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmVaHFC/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6738BE0
	for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 01:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722389118; cv=none; b=KCz/FEi8GG9+ca50eTPgUnCISup+uTIOCASJOoYdDREaMPrKPITReXdyY0sK+e5TG4o+EFzkDc+clFSd+vwbN8Q9qAoXHlvJKvDvkhvUKB3Y04pV6vDbjvLr32KXKU+1zLl8R0Vu+ypht6zyKifp7xbOeWnKKzuh9XcRZ+ZWSO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722389118; c=relaxed/simple;
	bh=R82Aoq4dVzmJfJglGNhyMnhlxWzR4gflEnwTK8ohcNE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ilbFbkgK2GyUJlyA3GLygYJ602VW1mwnuT5n/Wu+omPQpIjEp7pcEEX2MXZe0/4m9tCjJ8esiQUtZQigr8Kk9Y5y2u5rWgakjaLzc61JJeukEZp4a9fPWIE4xhd5f/OkohwaxVm3HqR3e404XdLqO4w8vUX7emICdq9GV7PB0k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmVaHFC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19EDC32782;
	Wed, 31 Jul 2024 01:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722389118;
	bh=R82Aoq4dVzmJfJglGNhyMnhlxWzR4gflEnwTK8ohcNE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pmVaHFC/H2PkRdb0ustL7tnAHygYwtyE9ZPwGGyqdlmebuBXUd9Vw1UE0kgdffTdb
	 cAHA0XdZf4kWwmHo2b+f92yGNxiNeHOCaY601kD/dxJ26ehbCjeI5+l2Ce7gkZwyXq
	 fywEnJKyyyWJ6piqcVnJHPIceb3nxhfeJw3ePExnUm05Xf9euHf2XXzG5+mx++Gnck
	 hzyzNdTqpqU4v+fDNoHKGrx6B4x42MUsi3+jefGRRnRxP4M2sBy9usP5SgM0HyxPro
	 KtjOuCMx9K2fcdvpxCplt2oJmUXXQvbi7Mkj5ULKyf52Ud7V7zXQoUJPoqTeQQ+x3p
	 aHXdfMDTmQn2w==
Message-ID: <366f5bddad47957872aa2280a2f29eee80f950e8.camel@kernel.org>
Subject: Re: [PATCH bpf-next v3 4/6] selftests/bpf: Monitor traffic for
 tc_redirect.
From: Geliang Tang <geliang@kernel.org>
To: Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>,
  bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org,  kernel-team@meta.com, andrii@kernel.org, sdf@fomichev.me
Cc: kuifeng@meta.com
Date: Wed, 31 Jul 2024 09:25:10 +0800
In-Reply-To: <ccd4c20a-84f4-4677-b4e5-c0028e6e6f5a@gmail.com>
References: <20240730002745.1484204-1-thinker.li@gmail.com>
	 <20240730002745.1484204-5-thinker.li@gmail.com>
	 <7da1f071b59bebf6583844b79c72271cf4ab958d.camel@kernel.org>
	 <ccd4c20a-84f4-4677-b4e5-c0028e6e6f5a@gmail.com>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-07-30 at 09:33 -0700, Kui-Feng Lee wrote:
> 
> 
> On 7/30/24 02:43, Geliang Tang wrote:
> > On Mon, 2024-07-29 at 17:27 -0700, Kui-Feng Lee wrote:
> > > Enable traffic monitoring for the test case tc_redirect.
> > > 
> > > Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> > > ---
> > >   .../selftests/bpf/prog_tests/tc_redirect.c    | 48
> > > ++++++++++++++---
> > > --
> > >   1 file changed, 36 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
> > > b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
> > > index 327d51f59142..46d397c5c79a 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
> > > @@ -68,6 +68,7 @@
> > >   		__FILE__, __LINE__, strerror(errno),
> > > ##__VA_ARGS__)
> > >   
> > >   static const char * const namespaces[] = {NS_SRC, NS_FWD,
> > > NS_DST,
> > > NULL};
> > > +static struct netns_obj *netns_objs[3];
> > >   
> > >   static int write_file(const char *path, const char *newval)
> > >   {
> > > @@ -85,29 +86,52 @@ static int write_file(const char *path, const
> > > char *newval)
> > >   	return 0;
> > >   }
> > >   
> > > -static int netns_setup_namespaces(const char *verb)
> > > +enum NETNS_VERB {
> > > +	NETNS_ADD,
> > > +	NETNS_DEL,
> > > +};
> > > +
> > > +static int netns_setup_namespaces(enum NETNS_VERB verb)
> > >   {
> > >   	const char * const *ns = namespaces;
> > > -	char cmd[128];
> > > +	struct netns_obj **ns_obj = netns_objs;
> > >   
> > >   	while (*ns) {
> > > -		snprintf(cmd, sizeof(cmd), "ip netns %s %s",
> > > verb,
> > > *ns);
> > > -		if (!ASSERT_OK(system(cmd), cmd))
> > > -			return -1;
> > > +		if (verb == NETNS_ADD) {
> > 
> > Maybe better to keep "verb" parameter as "char *", and use
> > 
> > 		if (!strcmp(verb, "add"))
> > 
> > here instead?
> 
> I have no strong opinion here.
> May I know why you think string is better here?

I don't mean that string is better, I mean that "keep using strings" is
better. If we continue to use string, test_tc_redirect_peer_l3 and
test_tc_redirect_run_tests can remain unchanged, it at least makes this
patch smaller.

> 
> > 
> > > +			*ns_obj = netns_new(*ns, false);
> > > +			if (!*ns_obj) {
> > > +				log_err("netns_new failed");
> > > +				return -1;
> > > +			}
> > > +		} else {
> > > +			if (!*ns_obj) {
> > > +				log_err("netns_obj is NULL");
> > > +				return -1;
> > > +			}
> > > +			netns_free(*ns_obj);
> > > +			*ns_obj = NULL;
> > > +		}
> > >   		ns++;
> > > +		ns_obj++;
> > >   	}
> > >   	return 0;
> > >   }
> > >   
> > > -static void netns_setup_namespaces_nofail(const char *verb)
> > > +static void netns_setup_namespaces_nofail(enum NETNS_VERB verb)
> > >   {
> > >   	const char * const *ns = namespaces;
> > > -	char cmd[128];
> > > +	struct netns_obj **ns_obj = netns_objs;
> > >   
> > >   	while (*ns) {
> > > -		snprintf(cmd, sizeof(cmd), "ip netns %s %s >
> > > /dev/null 2>&1", verb, *ns);
> > > -		system(cmd);
> > > +		if (verb == NETNS_ADD) {
> > > +			*ns_obj = netns_new(*ns, false);
> > > +		} else {
> > > +			if (*ns_obj)
> > > +				netns_free(*ns_obj);
> > > +			*ns_obj = NULL;
> > > +		}
> > >   		ns++;
> > > +		ns_obj++;
> > >   	}
> > >   }
> > >   
> > > @@ -1250,17 +1274,17 @@ static void
> > > test_tc_redirect_peer_l3(struct
> > > netns_setup_result *setup_result)
> > >   	({
> > >                          \
> > >   		struct netns_setup_result setup_result = {
> > > .dev_mode
> > > = mode, };             \
> > >   		if
> > > (test__start_subtest(#name))
> > >      \
> > > -			if
> > > (ASSERT_OK(netns_setup_namespaces("add"),
> > > "setup namespaces")) { \
> > > +			if
> > > (ASSERT_OK(netns_setup_namespaces(NETNS_ADD), "setup
> > > namespaces")) {
> > > \
> > >   				if
> > > (ASSERT_OK(netns_setup_links_and_routes(&setup_result),  \
> > >   					      "setup links and
> > > routes"))                    \
> > >   					test_ ##
> > > name(&setup_result);                       \
> > > -
> > > 				netns_setup_namespaces("delete")
> > > ;                           \
> > > +				netns_setup_namespaces(NETNS_DEL
> > > );
> > >                          \
> > >   			}
> > >                          \
> > >   	})
> > >   
> > >   static void *test_tc_redirect_run_tests(void *arg)
> > >   {
> > > -	netns_setup_namespaces_nofail("delete");
> > > +	netns_setup_namespaces_nofail(NETNS_DEL);
> > >   
> > >   	RUN_TEST(tc_redirect_peer, MODE_VETH);
> > >   	RUN_TEST(tc_redirect_peer, MODE_NETKIT);
> > 
> 


