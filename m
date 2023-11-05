Return-Path: <bpf+bounces-14261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD9B7E15F9
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 20:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA4A1C20A23
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 19:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BDFD2FF;
	Sun,  5 Nov 2023 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b="TvItEzuY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qkp6gMZP"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8221F17D8
	for <bpf@vger.kernel.org>; Sun,  5 Nov 2023 19:09:13 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E4DDE
	for <bpf@vger.kernel.org>; Sun,  5 Nov 2023 11:09:10 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 902025C00FC;
	Sun,  5 Nov 2023 14:09:07 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Sun, 05 Nov 2023 14:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699211347; x=1699297747; bh=Zl
	rpZXnahueF5ZfDBvsJ7wW6MMUjCBVpwsFz7XhKxIQ=; b=TvItEzuY2tt+lNt2FW
	iQwc3LipEs+V1D9c4i5dEOAWqXREuqUUNSUGWVkffu7OnCiqsAGfYROc4wVw7PQ+
	rnaSaFb4uHO52shLEWP+45mF5wVeX9cGHX4deYz0BeMf6bTlv51rBDl9xRGo1eXK
	sKdZ06MQxQLbkL/F3Fp18ZD57unan5jWNJIUDbvbsY1S7ym4zIyt5WZj3kBnZn+N
	mFoRL2RlQrSqx4CoQAWM7KIjZKf29akB31GzkJDNQKW/Yju7rAkh+5qOrWhjIIqp
	F+nVBvjQXPdurrhSFStCEiqq4eqGzKJfS/LgD/IWUvvFT45fIv2IeGbK6K9pSs3u
	sCkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699211347; x=1699297747; bh=ZlrpZXnahueF5
	ZfDBvsJ7wW6MMUjCBVpwsFz7XhKxIQ=; b=qkp6gMZPCxdgHQHPyDUtykXuKsFhH
	winD+zhTiiakakAGxy2AvYxnL6tu7B1fJIpG61w4U3It98ehM5BAOeYX5QGS6uCE
	n0CHe/8WAsO4rCZk17ywjrsVuuROJ0qI9YIXvL2C9V+PHy7YwgLk/eKA3wiJnrm9
	o9emg1ReGbH+Lzd00TiSZLlcUc/XgfnivnPsuIn7VZvsTBcGxSWQFgBtyXpJRnnk
	I1S6AkUw1UhWVL6mvWFXQqKxkMU/DDcsCHqvnePRu4qwFiNNiYZPAI9nsp3x3Vqo
	5eGh5xv2QKjieEV1Yph+48CE7Oib5ZHzpvTPx59FpqRj4xqmWvf0oJ33g==
X-ME-Sender: <xms:UuhHZUM_HxhNYuFdjGcfsm9cZkI6dAEqnB1wydDIZlHtMkoxifLO4g>
    <xme:UuhHZa893gu3Wk-7fxkrCXwFbFxGQGXn0TY8uZI4o0_CxNhouHcRHpsfdir6WX7YJ
    gPl1QagtVkoGqbGy_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduvddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtse
    httdertderredtnecuhfhrohhmpedfffgrvhhiugcutfhhvghinhhssggvrhhgfdcuoegu
    rghvihgusehrvggruggrhhgvrggurdgvuheqnecuggftrfgrthhtvghrnhepfeelgeeuhe
    eihfeuleefleehtdektdeihffguddvheefiefhveelhedvvdfhueeinecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuggrvhhiugesrhgvrggurg
    hhvggrugdrvghu
X-ME-Proxy: <xmx:UuhHZbTVv09qZb3TjtDnAqQd_r65ixnNcJeTQ7G2G5Vhyo1lCQnyPA>
    <xmx:UuhHZcshga0zrjieoRSK5GQG59Bad7_eKE7S7XQ5XpclGj2hmZGqew>
    <xmx:UuhHZceJv1G50FXArZ3NZPJC_ptqZx13Tyuv1YY2ka0kAgIiPwtBug>
    <xmx:U-hHZS13UJS7-3TbzET8xNGKeLZbpnaZiEDneLGOjyDodusOrEUr8w>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 748A61700093; Sun,  5 Nov 2023 14:09:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1d237338-6341-45be-9f0e-f1f1a9bdc153@app.fastmail.com>
In-Reply-To: <20231105085801.3742-1-dev@der-flo.net>
References: <20231105085801.3742-1-dev@der-flo.net>
Date: Sun, 05 Nov 2023 20:08:43 +0100
From: "David Rheinsberg" <david@readahead.eu>
To: "Florian Lehner" <dev@der-flo.net>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, daniel@zonque.org
Subject: Re: [PATCH bpf-next] bpf, lpm: fix check prefixlen before walking trie
Content-Type: text/plain

Hi

On Sun, Nov 5, 2023, at 9:58 AM, Florian Lehner wrote:
> When looking up an element in LPM trie, the condition 'matchlen ==
> trie->max_prefixlen' will never return true, if key->prefixlen is larger
> than trie->max_prefixlen. Consequently all elements in the LPM trie will
> be visited and no element is returned in the end.
>
> To resolve this, check key->prefixlen first before walking the LPM trie.

Am I understanding you right that this is an optimization to avoid walking the entire trie? Because the way I read your commit-message I assume the output has always been NULL? Or am I missing something.

Do you have a specific use-case where such lookups are common? Can you explain why it is important to optimize this case? Because you now add a condition for every lookup just to optimize for the lookup-miss of a special case. I don't think I understand your reasoning here, but I might be missing some context.

Thanks!
David

> Fixes: b95a5c4db09b ("bpf: add a longest prefix match trie map implementation")
> Signed-off-by: Florian Lehner <dev@der-flo.net>
> ---
>  kernel/bpf/lpm_trie.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> index 17c7e7782a1f..b32be680da6c 100644
> --- a/kernel/bpf/lpm_trie.c
> +++ b/kernel/bpf/lpm_trie.c
> @@ -231,6 +231,9 @@ static void *trie_lookup_elem(struct bpf_map *map, 
> void *_key)
>  	struct lpm_trie_node *node, *found = NULL;
>  	struct bpf_lpm_trie_key *key = _key;
> 
> +	if (key->prefixlen > trie->max_prefixlen)
> +		return NULL;
> +
>  	/* Start walking the trie from the root node ... */
> 
>  	for (node = rcu_dereference_check(trie->root, rcu_read_lock_bh_held());
> -- 
> 2.39.2

