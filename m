Return-Path: <bpf+bounces-1899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9087233F4
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 02:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4868D1C20DDC
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 00:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF85D360;
	Tue,  6 Jun 2023 00:06:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DCC7F
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 00:06:08 +0000 (UTC)
Received: from sonic311-31.consmr.mail.ne1.yahoo.com (sonic311-31.consmr.mail.ne1.yahoo.com [66.163.188.212])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D442F7
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 17:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686009962; bh=6qYPzKUFfd0eU8EErIAIej1TDIjJHmEfk9WtTiQswzY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=prPenf+ytJ11wgWnr4Mejc7ztaIJyFRp8I5ynFDoEMVUlQyjbLH6ukJo6lv/DvNwVaeAxkgF1LppiZwBLJgkr5wlYmvQiysqd1zH8Z3OjAVgsDJB8RIUfSKSOs4RUP0IyWhlRKuxlfiZUPuG9m9jzdErGIQlHLAZ7jCZiWH9j0I4R9wpuOqBg2xsaGn3LNHtKvG/1mk75C6C1bIbwpuQQCIAID4jd/evedCVNxyXj1RtgUJbMeEQ1pMOp3YaOU+VTdOaOsQ8A6tjB5Va5voUTW+Isd01gKtx3OLUxGtSABZy6JaIIejs7cienVH8SoUOO8T9sg91hHIAk8mQBmbWWg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686009962; bh=h+dafeG+KHSRNwNyxizaOkKRjkfru4lq2tP2PNiPrqn=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=mMvpk/Llm1t6cryeVUfSLBrBgKLhZobClS1NuNqME26oIHjVszSyc7NCHt1IsrGQF6EZ1Irkv2d0l8EyMQIIBHq5bzXohZKqbqQCE75o/38+ZYcR5HVPBhoz53O+fR6uCfNgaqjGPBOIfTAPD2mmHWoolQI1TRr6rR467m9spkPksyFEMXS61vAbcIZV1xPXAYT6SO94cTLXf8gzTOcMgpLb6L2nI5wk77LXN2h8wgkDqsb0yAzWtntUrxy7u+qERVX/O57umFjmpHnTH3Hp0PFqDPgoDElv02oLzUIFx0an8bch4CC1unSmv/6RpEDshGOLMJd1Fs3aLRVbcR8SzA==
X-YMail-OSG: 47VqjHQVM1kePkhMnbOOaQVj5Z5xmbccNna9StD7oxyqbJrdevrs0.o7xAe8yrw
 b.OXrgn3lyEedUC0FWWwb6Ow6txWvlb4y2IWVzM7Pdq11rVLSQFDHvg3WPLrjGB2GDbzLpnVwjJz
 _v.g3L_zhKKLvnEK_nW6SEMVQS2QyavaZ.HVS2OHYlISZIhGlTztru3sZdphsDXWq2niMgu8UXYX
 u6qblwdWNJU5Oa66FEkNTt8Iv8RNlmuQHI8rwivBdkIXEvJQd1VCL8FDWelPhCgq819y3pNajg5o
 T4Ap7Re3eGjaeRlxnyf8ytjHHfDUYciR0b94BNzdctTZrFogkwRZrA9rGuSuSU3BIt9pkC6rC5vk
 vg3t8o_RFhrzYjEBkCZr69NNDTkFGINB7aQo5ENV.FNJxa69HuXhSfYSIPw_RnC.l87tr1uS7V18
 2jPg0XSPh4AVEGSjZD5fPhWVZIAoxjBWe4K6Qxv2rkxa9yFjzoBZIy4IQG3YtVEN5nEaRKF2RiGT
 MWNXoFdqOTYMRWCZ_dN3CjGS9UOGXw3HriHqHeJfFxbieJB3LNrVMH8ceBTSRx0uCptGZt5QpYXR
 CXco2GpD_6SD.I.m079D.vSDKw7Zm7GDYiQmT8pGMMV.7JHzBCxeTjt_q4FoVTY_q7KKGJcqchoi
 4paafNdiwoUrB.m7x76JkWrkwz0gHHvPjUjyc5g2.hkIfmhufgRAH4if8lyB2So..EgHkyzZsB_J
 yV_wof1wmDFI2yBbEzXkmhqkHozFba8TG9S5HBcUaj7HEnWvtBUsIFave_vizkvLI2HYX_xFClIa
 rwP1SDsh.DS7qlofjmeD0KK4G6kWHMEf.OdmuNsQY2DBAlQ8ejVlxnMiUO9Xk8MlhXr2YDv8g0UI
 rYWpqrvA84A8KoX0ACL6_RNXGNwYzqyw7sA_xNBzLQvQSq1EPxCE_FKQ24pWRzRzy2KGu246_JjM
 QC2amBYvk.M3tOC_jWs2ehYyoDmKAAS0GMWNB0lIDxeBoRQ_luTjPL9SIkit8JoGRHWG4T12zZZW
 zeHM5lYfl0VVuxlnYAhY_DBb1IJLgCLRQzKV_0f7o1nlTsuamnbuhexWoZYe4esXRjb834N7DuCP
 LCA5FyRYfYnZyyzQxADVnuNbvNfXAn7g2oBYU7Z_9MSot3EQbi0bFvRZgtaViJXM8W.8_BNMMtnw
 pP2968xGtvctkz7ETaN8xUSG7MLoLCa8hnyO680tMwgbvVbAhrcfD2DmqabwJgFtE4irsxR1OniS
 r3wGXnZv1KjlzCYKSu.PsUW8ChOlSmZJTouyT4fK5QrjQ4RS7FraKgoYCYPDT.DVdjzjzFoboDXe
 ZsDG2yaf_wTB8YyI36j7yIku2XMGAUtIPRzRmCQGy78JtA44jvv6CSyDW8J88PZJx3iVFudlch5e
 i7DuS72MLk5r6rrLNTP1fm_5wOr6qCQ1J7TCy1pUnn2iUlf2TH3gv_B0ZHW56JeZMjzilKPGz8lH
 uNmepxjrUVkE1rC.xens0.5EHm4rF.PofdRlM5N25dwVBynBqmX7eqJbOLdcboLZmPMyLOPM9IJw
 ARHNxs0nVagzCwHLuurTxbO095VQD0tqTmluM990pbTkC4iHvdwJmjpdruHfa_kJbGzZIxyrquNJ
 N4usP79UwkRptAtunJuCH32d_g7vOEJTreKywmlLwflnuBhV7r7UH_LWYPmrTgCH5Qmjw6nwPONi
 1hl8_6o75wnoeFgzu6gia7rwFbNqncmRf.iwVC8VUats_ClgdIUavrgi3PeBOj7OXfXgv8HfAJak
 dVv91ACWH.TBOHPSLQAoYo0UqtITJb7wUUYjZuTx.aYWlwV1brueYT_3gLqt2HpN1cFZlqFaJzEV
 eCTkdb2VXytMtomJtLy1mLOT_ocUfrwEH9oWY3Qonl3ndU.W7MHnBJFttfydBJ1mlW2W4_R6sDt7
 FalV8_a7hqxCr10zpnYIIZxSjmOcWt370k0WhfXCaUH5YU8WFH9vehDpBwpiEo51j4ZsW4tf41Tv
 _RgABTd8bHk72yij9tktGPnYTpYDYHsv.3hDeF.U0zAVpC6L5CXhFejxgNhl9ak2so4P7yG7Lnqc
 aXjpVf9r5LPe7oHntLImzqa1x_HgmxdHVSVCrrVIizbVJF2NnQfHyz.IMaofcl8JWlLSMMZvGyQT
 MoX3rdtWIgtqPXRNZDycAY5wo65k8C80FeWGE3_a2lE5D4gB0vIgBFIZZC_zFDXcTb642la46rqt
 37PWVTHYJYcXoyP2p10ZAGCg9wHYZVKY-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: db14d11e-0135-41ff-ab7f-a5ded88fa15d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 6 Jun 2023 00:06:02 +0000
Received: by hermes--production-ne1-574d4b7954-tvjss (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b42c56513b3be67b9e8b2d2b22bb4aea;
          Tue, 06 Jun 2023 00:05:59 +0000 (UTC)
Message-ID: <a61d8739-300f-67b0-7e7a-acf8fb1a44a8@schaufler-ca.com>
Date: Mon, 5 Jun 2023 17:05:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RESEND bpf-next 00/18] BPF token
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, keescook@chromium.org,
 brauner@kernel.org, lennart@poettering.net, cyphar@cyphar.com,
 luto@kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20230602150011.1657856-1-andrii@kernel.org>
 <1930272b-cfbe-f366-21ca-e9e7a51347be@schaufler-ca.com>
 <CAEf4BzZ5adUcs1qaHx34ZuXMyG6ByczyUqpFKq=+CtxPHYgEVQ@mail.gmail.com>
 <24dcbfec-1527-ab14-9726-ca91d68f35d4@schaufler-ca.com>
 <CAEf4BzYj9YY==awasOt+ufJGJj7P2g6qC6aMxX-Phos01aUXqw@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAEf4BzYj9YY==awasOt+ufJGJj7P2g6qC6aMxX-Phos01aUXqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21516 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/5/2023 4:12 PM, Andrii Nakryiko wrote:
> On Mon, Jun 5, 2023 at 3:26 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 6/5/2023 1:41 PM, Andrii Nakryiko wrote:
>>> On Fri, Jun 2, 2023 at 8:55 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> On 6/2/2023 7:59 AM, Andrii Nakryiko wrote:
>>>>> *Resending with trimmed CC list because original version didn't make it to
>>>>> the mailing list.*
>>>>>
>>>>> This patch set introduces new BPF object, BPF token, which allows to delegate
>>>>> a subset of BPF functionality from privileged system-wide daemon (e.g.,
>>>>> systemd or any other container manager) to a *trusted* unprivileged
>>>>> application. Trust is the key here. This functionality is not about allowing
>>>>> unconditional unprivileged BPF usage. Establishing trust, though, is
>>>>> completely up to the discretion of respective privileged application that
>>>>> would create a BPF token.
>>>> Token based privilege has a number of well understood weaknesses,
>>>> none of which I see addressed here. I also have a real problem with
>>> Can you please provide some more details about those weaknesses? Hard
>>> to respond without knowing exactly what we are talking about.
>> Privileged Process (PP) sends a Token to Trusted Process (TP).
>> TP sends the Token along to Untrusted Process, which performs nefarious
>> deeds.
>>
>> Privileged Process (PP) sends a Token to Trusted Process (TP).
>> TP uses Token, and then saves it in its toolbox. PP later sends
>> TP a different Token. TP realizes that with the combination of
>> Tokens it now has it can do considerably more than what PP
>> intended in either of the cases it sent Token for. TP performs
>> nefarious deeds.
>>
>> Granted, in both cases TP does not deserve to be trusted.
> Right, exactly. The intended use case here is a controlled production
> containerized environment, where the container manager is privileged
> and controls which applications are run inside the container. These
> are coming from applications that are code reviewed and controlled by
> whichever organization.

I understand the intended use case. You have to allow for unintended abuse
cases when you implement a security mechanism. You can't wave your hand and
say that everything that is trusted in worthy of trust. You have to have
mechanism to ensure that. The existing security mechanisms (uids, capabilities
and so forth) have explicit criteria for how they delegate privilege, and
what the consequences of doing so might be.

>
>> Because TP does not run with privilege of its own, it is not
>> treated with the same level of caution as it would be if it did.
>>
>> Privileged Process (PP) sends a Token to what it thinks is a Trusted
>> Process (TP) but is in fact an Imposter Process (IP) that has been
>> enabled on the system using any number of K33L techniques.
> So if there is a probability of Imposter Process, neither BPF token
> nor CAP_BPF should be granted at all. In production no one gives
> CAP_BPF to processes that we cannot be reasonably sure is safe to use
> BPF. As I mentioned in the cover letter, BPF token is not a mechanism
> to implement unprivileged BPF.

You're correct, PP *shouldn't* grant IP a Token. But it *can* do so.
Think of the military definition of a threat. It's what the other guy
is capable of doing to you, not what the other guy is expected to do to you.
PP is capable to giving a Token to IP, even if PP does not intend to.

> What I'm trying to achieve here is instead of needing to grant root
> capabilities to any (trusted, otherwise no one would do this)
> BPF-using application, we'd like to grant BPF token which is more
> limited in scope and gives much less privileges to do anything with
> the system. And, crucially, CAP_BPF is incompatible with user
> namespaces, while BPF token is.

I get that. Dynamically increasing a process' privilege (TP) from an
external source (PP) without somehow marking TP as worthy of the privilege
is going to be insanely dangerous. Even in well controlled environments. 

>
> Basically, I'd like to go from having root/CAP_BPF processes in init
> namespace, to have unprivileged processes under user namespace, but
> with BPF token that would still allow to do them controlled (through
> combination of code reviews, audit, and security enforcements) BPF
> usage.

And the problem there is that if you put the feature in the kernel
you can assume that some number of people will use it without code
reviews, audit or security enforcement. Of course you can call out
"user error", but someone is going to want you to "fix" it. 

>
>> I don't see anything that ensures that PP communicates Tokens only
>> to TP, nor any criteria for "trust" are met.
> This should be up to PP how to organize this and will differ in
> different production setups. E.g., for something like systemd or
> container manager, one way to communicate this is to create a
> dedicated instance of BPF FS, pin BPF token in it, and expose that
> specific instance of BPF FS in the container's mount namespace.

I have no doubt that you can make a system that works and works correctly.
I'm saying that it's very easy to create a system that had easily exploited
security holes. You won't do it, but someone who didn't design your
mechanism will.

>
>> Those are the issues I'm most familiar with, although I believe
>> there are others.
>>
>>>> the notion of "trusted unprivileged" where trust is established by
>>>> a user space application. Ignoring the possibility of malicious code
>>>> for the moment, the opportunity for accidental privilege leakage is
>>>> huge. It would be trivial (and tempting) to create a privileged BPF
>>>> "shell" that would then be allowed to "trust" any application and
>>>> run it with privilege by passing it a token.
>>> Right now most BPF applications are running as real root in
>>> production. Users have to trust such applications to not do anything
>>> bad with their full root capabilities. How it is done depends on
>>> specific production and organizational setups, and could be code
>>> reviewing, audits, LSM, etc. So in that sense BPF token doesn't make
>>> things worse. And it actually allows us to improve the situation by
>>> creating and sharing more restrictive BPF tokens that limit what bpf()
>>> syscall parts are allowed to be used.
>>>
>>>>> The main motivation for BPF token is a desire to enable containerized
>>>>> BPF applications to be used together with user namespaces. This is currently
>>>>> impossible, as CAP_BPF, required for BPF subsystem usage, cannot be namespaced
>>>>> or sandboxed, as a general rule. E.g., tracing BPF programs, thanks to BPF
>>>>> helpers like bpf_probe_read_kernel() and bpf_probe_read_user() can safely read
>>>>> arbitrary memory, and it's impossible to ensure that they only read memory of
>>>>> processes belonging to any given namespace. This means that it's impossible to
>>>>> have namespace-aware CAP_BPF capability, and as such another mechanism to
>>>>> allow safe usage of BPF functionality is necessary. BPF token and delegation
>>>>> of it to a trusted unprivileged applications is such mechanism. Kernel makes
>>>>> no assumption about what "trusted" constitutes in any particular case, and
>>>>> it's up to specific privileged applications and their surrounding
>>>>> infrastructure to decide that. What kernel provides is a set of APIs to create
>>>>> and tune BPF token, and pass it around to privileged BPF commands that are
>>>>> creating new BPF objects like BPF programs, BPF maps, etc.
>>>>>
>>>>> Previous attempt at addressing this very same problem ([0]) attempted to
>>>>> utilize authoritative LSM approach, but was conclusively rejected by upstream
>>>>> LSM maintainers. BPF token concept is not changing anything about LSM
>>>>> approach, but can be combined with LSM hooks for very fine-grained security
>>>>> policy. Some ideas about making BPF token more convenient to use with LSM (in
>>>>> particular custom BPF LSM programs) was briefly described in recent LSF/MM/BPF
>>>>> 2023 presentation ([1]). E.g., an ability to specify user-provided data
>>>>> (context), which in combination with BPF LSM would allow implementing a very
>>>>> dynamic and fine-granular custom security policies on top of BPF token. In the
>>>>> interest of minimizing API surface area discussions this is going to be
>>>>> added in follow up patches, as it's not essential to the fundamental concept
>>>>> of delegatable BPF token.
>>>>>
>>>>> It should be noted that BPF token is conceptually quite similar to the idea of
>>>>> /dev/bpf device file, proposed by Song a while ago ([2]). The biggest
>>>>> difference is the idea of using virtual anon_inode file to hold BPF token and
>>>>> allowing multiple independent instances of them, each with its own set of
>>>>> restrictions. BPF pinning solves the problem of exposing such BPF token
>>>>> through file system (BPF FS, in this case) for cases where transferring FDs
>>>>> over Unix domain sockets is not convenient. And also, crucially, BPF token
>>>>> approach is not using any special stateful task-scoped flags. Instead, bpf()
>>>>> syscall accepts token_fd parameters explicitly for each relevant BPF command.
>>>>> This addresses main concerns brought up during the /dev/bpf discussion, and
>>>>> fits better with overall BPF subsystem design.
>>>>>
>>>>> This patch set adds a basic minimum of functionality to make BPF token useful
>>>>> and to discuss API and functionality. Currently only low-level libbpf APIs
>>>>> support passing BPF token around, allowing to test kernel functionality, but
>>>>> for the most part is not sufficient for real-world applications, which
>>>>> typically use high-level libbpf APIs based on `struct bpf_object` type. This
>>>>> was done with the intent to limit the size of patch set and concentrate on
>>>>> mostly kernel-side changes. All the necessary plumbing for libbpf will be sent
>>>>> as a separate follow up patch set kernel support makes it upstream.
>>>>>
>>>>> Another part that should happen once kernel-side BPF token is established, is
>>>>> a set of conventions between applications (e.g., systemd), tools (e.g.,
>>>>> bpftool), and libraries (e.g., libbpf) about sharing BPF tokens through BPF FS
>>>>> at well-defined locations to allow applications take advantage of this in
>>>>> automatic fashion without explicit code changes on BPF application's side.
>>>>> But I'd like to postpone this discussion to after BPF token concept lands.
>>>>>
>>>>>   [0] https://lore.kernel.org/bpf/20230412043300.360803-1-andrii@kernel.org/
>>>>>   [1] http://vger.kernel.org/bpfconf2023_material/Trusted_unprivileged_BPF_LSFMM2023.pdf
>>>>>   [2] https://lore.kernel.org/bpf/20190627201923.2589391-2-songliubraving@fb.com/
>>>>>
>>>>> Andrii Nakryiko (18):
>>>>>   bpf: introduce BPF token object
>>>>>   libbpf: add bpf_token_create() API
>>>>>   selftests/bpf: add BPF_TOKEN_CREATE test
>>>>>   bpf: move unprivileged checks into map_create() and bpf_prog_load()
>>>>>   bpf: inline map creation logic in map_create() function
>>>>>   bpf: centralize permissions checks for all BPF map types
>>>>>   bpf: add BPF token support to BPF_MAP_CREATE command
>>>>>   libbpf: add BPF token support to bpf_map_create() API
>>>>>   selftests/bpf: add BPF token-enabled test for BPF_MAP_CREATE command
>>>>>   bpf: add BPF token support to BPF_BTF_LOAD command
>>>>>   libbpf: add BPF token support to bpf_btf_load() API
>>>>>   selftests/bpf: add BPF token-enabled BPF_BTF_LOAD selftest
>>>>>   bpf: keep BPF_PROG_LOAD permission checks clear of validations
>>>>>   bpf: add BPF token support to BPF_PROG_LOAD command
>>>>>   bpf: take into account BPF token when fetching helper protos
>>>>>   bpf: consistenly use BPF token throughout BPF verifier logic
>>>>>   libbpf: add BPF token support to bpf_prog_load() API
>>>>>   selftests/bpf: add BPF token-enabled BPF_PROG_LOAD tests
>>>>>
>>>>>  drivers/media/rc/bpf-lirc.c                   |   2 +-
>>>>>  include/linux/bpf.h                           |  66 ++-
>>>>>  include/linux/filter.h                        |   2 +-
>>>>>  include/uapi/linux/bpf.h                      |  74 +++
>>>>>  kernel/bpf/Makefile                           |   2 +-
>>>>>  kernel/bpf/arraymap.c                         |   2 +-
>>>>>  kernel/bpf/bloom_filter.c                     |   3 -
>>>>>  kernel/bpf/bpf_local_storage.c                |   3 -
>>>>>  kernel/bpf/bpf_struct_ops.c                   |   3 -
>>>>>  kernel/bpf/cgroup.c                           |   6 +-
>>>>>  kernel/bpf/core.c                             |   3 +-
>>>>>  kernel/bpf/cpumap.c                           |   4 -
>>>>>  kernel/bpf/devmap.c                           |   3 -
>>>>>  kernel/bpf/hashtab.c                          |   6 -
>>>>>  kernel/bpf/helpers.c                          |   6 +-
>>>>>  kernel/bpf/inode.c                            |  26 ++
>>>>>  kernel/bpf/lpm_trie.c                         |   3 -
>>>>>  kernel/bpf/queue_stack_maps.c                 |   4 -
>>>>>  kernel/bpf/reuseport_array.c                  |   3 -
>>>>>  kernel/bpf/stackmap.c                         |   3 -
>>>>>  kernel/bpf/syscall.c                          | 429 ++++++++++++++----
>>>>>  kernel/bpf/token.c                            | 141 ++++++
>>>>>  kernel/bpf/verifier.c                         |  13 +-
>>>>>  kernel/trace/bpf_trace.c                      |   2 +-
>>>>>  net/core/filter.c                             |  36 +-
>>>>>  net/core/sock_map.c                           |   4 -
>>>>>  net/ipv4/bpf_tcp_ca.c                         |   2 +-
>>>>>  net/netfilter/nf_bpf_link.c                   |   2 +-
>>>>>  net/xdp/xskmap.c                              |   4 -
>>>>>  tools/include/uapi/linux/bpf.h                |  74 +++
>>>>>  tools/lib/bpf/bpf.c                           |  32 +-
>>>>>  tools/lib/bpf/bpf.h                           |  24 +-
>>>>>  tools/lib/bpf/libbpf.map                      |   1 +
>>>>>  .../selftests/bpf/prog_tests/libbpf_probes.c  |   4 +
>>>>>  .../selftests/bpf/prog_tests/libbpf_str.c     |   6 +
>>>>>  .../testing/selftests/bpf/prog_tests/token.c  | 282 ++++++++++++
>>>>>  .../bpf/prog_tests/unpriv_bpf_disabled.c      |   6 +-
>>>>>  37 files changed, 1098 insertions(+), 188 deletions(-)
>>>>>  create mode 100644 kernel/bpf/token.c
>>>>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/token.c
>>>>>

