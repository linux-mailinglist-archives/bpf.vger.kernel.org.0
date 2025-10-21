Return-Path: <bpf+bounces-71501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE22ABF5E4C
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 12:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52607502704
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 10:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3694632D0FC;
	Tue, 21 Oct 2025 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UYk3zA5I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Npv0mdRr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RJ5wY9Sw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MKymBbHE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA2A23D7FB
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043928; cv=none; b=VdqHOQueg0SAjMLcXNLMzq7o3gbnXJ9F84D8Twp88kzol11WUAtYrfh8tzngEInF2illOJxlDw5Ru6kCE22kq4PwBmaY8Of/Eo57X6YJIpB/vuoFtxCRW0oPfALwE1tYpwlS78XRSrrpYUNcfD8nWfsZD+nKCwXZjfM7nIZpfnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043928; c=relaxed/simple;
	bh=09Lqe84KKzgJpR85NdRkX0PiWo7i/dASLhMTtLoTRYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UKdOMwGu2/QPmrTVhRJtAyfaeQWIA8uwhwxgC0sQSVoRGqwK0vkZhRXbk6rz+n1LGFcDtZf7gHccT6ZRvBGXUH8V5S5YnnKEbGbDhdZVvVbxGYRxZ7NhIAwsUqOLOUN9SnLWTIh60Pi39YQnoJ6ez1zctLWMTCXsthO0z7T4L2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UYk3zA5I; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Npv0mdRr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RJ5wY9Sw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MKymBbHE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ED5C3211C8;
	Tue, 21 Oct 2025 10:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761043921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7XP7QtIU8gKj770j1vZYLnbvcbRkQv38eNG7ETO4pCs=;
	b=UYk3zA5IjUNkZsjcQxP3pdFQ0/bZxAEnyVClPUPuzyROpaRchKCT4Nqb4ONKKaISIfpIlw
	E5wgO8DdDRRuBWpQ8dQfMVShhM67Yi4cPLHOBHmqr/Nu5X5/gVY4j/9OFPVpEZgVGkU+AX
	swoFztrKS2njOZ1FTyTa26SVGD+b088=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761043921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7XP7QtIU8gKj770j1vZYLnbvcbRkQv38eNG7ETO4pCs=;
	b=Npv0mdRr3tv/DJvS+6UFbHNnBWxDMrnjxNuqn7zpiAaV4Y0eWmTgpPqpaxG5DJz1WxDJBV
	K87792718Xv+jHBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RJ5wY9Sw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MKymBbHE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761043916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7XP7QtIU8gKj770j1vZYLnbvcbRkQv38eNG7ETO4pCs=;
	b=RJ5wY9SwB/hsdfbG99akV0FGV/GegdsKLOdRBR8vJa6bp0SFmZfheipPPlM3NsFwoAdwfI
	G61toC9OiPtIjCp2zUmYAJ1GmdxmKbT/oGQa2xuWu23BkBizA0q6J9pYb6Z4qBhu5QblGd
	7eg2zsIczdZ2VEdwGTByrQKgwer2LRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761043916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7XP7QtIU8gKj770j1vZYLnbvcbRkQv38eNG7ETO4pCs=;
	b=MKymBbHEiW9BmwQCNbXaeOgFb8gosorgrEjl+MTzuiTZZ6r5ywlzVilJxx2n/pKYr+Xm5E
	kT1nzX86B6OtRZAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DB58139D2;
	Tue, 21 Oct 2025 10:51:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iFoeFMxl92huGwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 21 Oct 2025 10:51:56 +0000
Message-ID: <7e58078f-8355-4259-b929-c37abbc1f206@suse.de>
Date: Tue, 21 Oct 2025 12:51:32 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: null pointer dereference in interrupt after receiving an ip
 packet on veth from xsk from user space
To: mc36 <csmate@nop.hu>, Jason Xing <kerneljasonxing@gmail.com>,
 alekcejk@googlemail.com
Cc: Jonathan Lemon <jonathan.lemon@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, 1118437@bugs.debian.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu>
 <CAL+tcoA5qDAcnZpmULsnD=X6aVP-ztRxPv5z1OSP-nvtNEk+-w@mail.gmail.com>
 <643fbe8f-ba76-49b4-9fb7-403535fd5638@nop.hu>
 <CAL+tcoDqgQbs20xV34RFWDoE5YPXS-ne3FBns2n9t4eggx8LAQ@mail.gmail.com>
 <d8808206-0951-4512-91cb-58839ba9b8c4@nop.hu>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <d8808206-0951-4512-91cb-58839ba9b8c4@nop.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: ED5C3211C8
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[nop.hu,gmail.com,googlemail.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,fomichev.me,intel.com,kernel.org,bugs.debian.org,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
X-Spam-Score: -3.01



On 10/20/25 11:31 PM, mc36 wrote:
> hi,
> 
> On 10/20/25 11:04, Jason Xing wrote:
>>
>> I followed your steps you attached in your code:
>> ////// gcc xskInt.c -lxdp
>> ////// sudo ip link add veth1 type veth
>> ////// sudo ip link set veth0 up
>> ////// sudo ip link set veth1 up
> 
> ip link set dev veth1 address 3a:10:5c:53:b3:5c
> 
>> ////// sudo ./a.out
>>
> that will do the trick on a recent kerlek....
> 
> its the destination mac in the c code....
> 
> ps: chaining in the original reporter from the fedora land.....
> 
> 
> have a nice day,
> 
> cs
> 
> 

hi, FWIW I have reproduced this and I bisected it, issue was introduced 
at 30f241fcf52aaaef7ac16e66530faa11be78a865 - working on a patch.

Thanks,
Fernando.

