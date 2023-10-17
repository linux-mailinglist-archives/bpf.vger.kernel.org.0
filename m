Return-Path: <bpf+bounces-12427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4393D7CC583
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 16:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FFB01C20975
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 14:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEE943A91;
	Tue, 17 Oct 2023 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KPZcdb2o"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5F229428
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 14:04:09 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58B3EA;
	Tue, 17 Oct 2023 07:04:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5863821CF8;
	Tue, 17 Oct 2023 14:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1697551447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5eWpfGTDNFvI8XGuKktMOmAiE8BgC2Q8/DBdyRPJaU=;
	b=KPZcdb2oN9xaAI0ORSOB2aGhnOH83/gqJjYM0KY1HKCk7gUnSds+n6DQr+s0p/l8btQFGI
	IasqYvCtFPSWieqEfv5pmSL8saszTOJJzWm+7GVOBE31Dkip3VyVPMpoYJs3MkDQKezMQx
	3KLad9Q6jURU+4jGCiaZWywhU+hIaSg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7281013584;
	Tue, 17 Oct 2023 14:04:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id w22JGlaULmUfCgAAMHmgww
	(envelope-from <mkoutny@suse.com>); Tue, 17 Oct 2023 14:04:06 +0000
Date: Tue, 17 Oct 2023 16:04:04 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	yosryahmed@google.com, sinquersw@gmail.com, cgroups@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v2 2/9] cgroup: Eliminate the need for
 cgroup_mutex in proc_cgroup_show()
Message-ID: <ujaxujz3xczccobmiu2jxsstn3n7v4ly7vp72dqbgu5dyonrrw@nhzk7fhrpkkp>
References: <20231017124546.24608-1-laoar.shao@gmail.com>
 <20231017124546.24608-3-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wrd4crw5beqobbcj"
Content-Disposition: inline
In-Reply-To: <20231017124546.24608-3-laoar.shao@gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.93
X-Spamd-Result: default: False [-6.93 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-2.73)[98.81%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[19];
	 SIGNED_PGP(-2.00)[];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,google.com,bytedance.com,cmpxchg.org,vger.kernel.org]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--wrd4crw5beqobbcj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi.

I'd like this proc_cgroup_show de-contention.
(Provided the previous patch and this one can be worked out somehow.)

On Tue, Oct 17, 2023 at 12:45:39PM +0000, Yafang Shao <laoar.shao@gmail.com=
> wrote:
> They can ran successfully after implementing this change, with no RCU
> warnings in dmesg. It's worth noting that this change can also catch
> deleted cgroups, as demonstrated by running the following task at the
> same time:

Can those be other than v1 root cgroups? A suffix "(unmounted)" may be
more informative then.

(Non-zombie tasks prevent their cgroup removal, zombie tasks won't have
any non-trivial path rendered.)


> @@ -6256,7 +6256,7 @@ int proc_cgroup_show(struct seq_file *m, struct pid=
_namespace *ns,
>  	if (!buf)
>  		goto out;
> =20
> -	cgroup_lock();
> +	rcu_read_lock();

What about the cgroup_path_ns_locked() that prints the path?

(I argue above that no non-trivial path is rendered but I'm not sure
whether rcu_read_lock() is sufficient sync wrt cgroup rmdir.)


--wrd4crw5beqobbcj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZS6UUgAKCRAGvrMr/1gc
jgyTAPwP0dS1YGXJ9+kIohmYAmHIISZWpLCKL9KIXVthR0M6iAD/WcLU1jG5G4IS
nyJIswE0pn4rA4LkyKjkWmoCILF0ww0=
=gIiG
-----END PGP SIGNATURE-----

--wrd4crw5beqobbcj--

