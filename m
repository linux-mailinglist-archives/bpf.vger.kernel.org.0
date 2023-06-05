Return-Path: <bpf+bounces-1887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D0D723325
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 00:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE2A281475
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 22:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1AD27732;
	Mon,  5 Jun 2023 22:26:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6A61C752
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 22:26:10 +0000 (UTC)
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D30F4
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 15:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686003967; bh=RntIbkCubVrBvldUdyUBt/Tm6/8GKJzG9x9Ibih65lc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ksDu9ECv8QIon5Zw0NcZ+MLwXqTQJw/V0qJlDTGMYF/1iC4LRhe8NCgmA9sJo9IP3rXan+87f5bFdBauUm5HXw559n0/ig8EmrYhT0N0WLIFof+FdYi6gGlxD1zw3UoguQOhtsAD7zK8PmOVmQNArkBHMxCGGJb6A6PKU7qkONAvcQJeQFiKi04ZTl60dHscYdholFYKcc6ltzA5e865r5EY2E7pDtnNP/GfJe4ImOrmXXZCjwN5c74yPG7iVRlUq9rgvOn+9WTKMm5UNmLTzLDyfOuC7iHXgEvdb09K/45TGX25foL4/eyIsS875EP1uqKoSWIH8piQipiayjoJSg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686003967; bh=GKK7NvLgJVJ1J7SHlQA5EM/tNOUAOtm2BYC3doYNIoe=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=gKaOpiU37CYCQ++eBQIGwcopmtgqz0FHJ1EO2ZAyEDCoWFgW3aI159a7angrfH9RI20nlokZrFGvXjirdLE6kDe+7KUcf3Xws1GMdIf+jwSMhI0u9u5mEHQWU9U+7dGhWeE7f2e/X1iXQ+rj4R3MJsCQ/Ozx/o/Npky+lAvf5kjV7FrUU7IhoRTKezS0ucFQafnvig63yCYJLVp0u+RC6nA6OGjT328nk9OijhUskLI5KC0Cy2njn6ZzVeb6QEzpeNQi1Lt+splsm4d8QAQR04fxlMNziAw5uNlh2+NTsfmWQVMBsDqTwH/Dhd1aU50t7U80l0lNJ48tjzivkwknRg==
X-YMail-OSG: I5fzcIcVM1kDSXHYsA9CSqPG6uFOcEOoAVNq0VVNd7iRk3b3P6WKiEfuSsUlZ8B
 6PVy3g._wMhlU8W4Vi1bx18JDGFjJQCBfzxmeBNTtqipAyjuBZHz_iKf0R0xMLY7XhJdK0dcwLKX
 oLqs0.gqtCzsAhfb5SJebNT1tCuTiW3c88xbB5x6ddjRCvHnlhQhMIAeQCPT2jCnYHbyW7_7OSR.
 RFIGozfBVxHaVpCmPn68ZUMdnGE0GAu6FrsxiorxQ78265ExROCAMZQkmcGVuv297JUYuB_y.3zE
 .q6Xvt2XJD3Qkx9S0Co6RNXY7VKD6ZJV0xC6.vQQrhRgyGbiYkci.hOKFe0.WP5yfA0d5G4ycvo8
 m_VNvov6rZ1_8udNzZvZoZwtzCtVYOR0IwzKJknJfjTawGpY.PRXJ5fJ1DM347JI8hG4SWrlrzKt
 hCi1wJsAZNySbu6K28Z.jopg5jsDPEFRxFAsi48mHyr7cnI5_TYY21a3aS9K.Yqsm1n3KP0mh2et
 BIxnx9lDDdPQFSFyh0Ze0w41KSJTnWsnvT5Bm1R2Z5AfTuuPaf2e3WRhIBAbVeAk1B4GVDqNuXJI
 .yUFczpca1_NX3D8r9MKlbclQ9xesxkLk0RPOaxBBbiRl4hQGuAoyZfx20hW2xV5pYWDCnlEozju
 aZOmflW2uLCpHUPt5td3i6ctovHi1kIazM4f.E.Nj1nqu8sDT3H0NReNXNKf0BcPwYtMZxS6jMJj
 jEHt7lDauY6yfPJIq2VZDBACGLyTGzpbhFPALllPl4ew1NQL.eQ8mL8RpFnEFcjLtxpmaM7u5dCO
 4W1Y3b5L.6JKwOZVnVgzM6VtDCe_WHUxh6P6ZzBx_Mim_UOpjxo6qu76I05Vc6A3.pDDRKbLD_0h
 7e.BHLTSMemFIAX2Id_Ca5gf0QYCwXSlf1De4gf_yu1gWnFxhg6y8IkcoK1Ir2OWbhbzjjKyXQh5
 7fgEH8WfAIoK_P5KyqsK_PCUN3dFDQwB4BUQ.B5s_9Gm7KzEzK5AkBUsuAI7jErPvHe2JZQEwk.0
 SR88zcwkhvQ7gy32eT9ZB_663Sjmt1mz0YDHxVIPJm0zCTsg6Q8smCuBVRVHzt_rttYL6EpmlnDX
 .ewHdtQV5tvCDiHCpM5dCp71Hni.O0PlNsVPWFhkxfpwiBkc3rrwwX5v23Xa7Hq_segbWwAuGfq.
 UpK9_IdTKSe.hr5lxatWAPrBa5bM2IqrEmq585Ubw.1CC5oJlj3AI6wCazfTTvkI9YaMH70fqDb6
 J6XuJJubNmiCEM_gcUWy_GcqmRhH_Q3nkj7m7jCj3hixNREZ2KnuKM8voYSbsA9ppWBKYRfzx65N
 Tw8EtqoG6MehrTGKxb8tbB2Zmd8cQ8dqDr.QXP8IwKAk8V0mjge8swLluwtVdNmS44mKfCAH0ttL
 ns653yWVOgwwUSFZHLJWRq4Qxh23QFc9oKpjipSGTcKl93PSKYZDPgjdpM6m0npUA.m4jZ6NlR7v
 KoD7TgY.fy9FCgnEL_JSSw4hPuQNJQLR6maeOMd9rai1kfh1ENMcYQIUdFekn952hoxntEWEZylS
 fvIJGJxMVDMnX5pHGtt46bWAqYux3HeI4XtR5T4z6sYrhSP2jfqeSMrS6KZgNa2DemAxBI6iCJlB
 LdnPyM7B8PajNJuZW5L6thlqmTXDPqqFgRTgYGTXqb6jXaxxa3U.9.tmOs.SjWjXj3O0om96w2_i
 iDsyRMLyctRaocCs0iEv9TlHpThlQ4dKFJAIdnNLfRWEyvz6eeVcvYanlIo.GZ4DK_fdLqUNKs9R
 bjxJ26a5Jsk8RCxVaPFp6nY.QirqPLOjH7zFsECddgernI4UpRDrST8ynrod3wiwcTSbbYQqeH23
 yqmdn3JS4aKJz68X64CRce9ps_GufIOysKueGNQUdW3uShKDuVNe2w7oYZYvEQHTv.xa636Gg2Sp
 ctHPQkk_XeDoluqO1.1o.uYDpyarvsXswBvgbztRssSlrkegNHMitv8pOXwnANKnTVdB9gw7wyPQ
 Vni1aDMc3E1hLUKjteiQnt_Z1.iKq.WU7fYb15trR5CAKY5fx9aUJVlxGLdN0hXCtzu0v9Nb__tJ
 gTtuZvWkcM.Xtub2Gnc1JW5JlfMi9SjoPQoH8eWGVks6i35Z5UgJF.60Eq0.eY53Mj8NBKc1uKuG
 O1N94k_54NuQp_H25bxZJ6MfpMeLbCFmUYk9YEWsLAZm7E_9ObzlqIonpneMtS.gYQ_2c_hdH061
 G.ll_6QHZNsuPQO_Aa8b2xQjZbERVW0Q-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e29c37a7-3370-4bc1-a4de-eecd7397998b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 5 Jun 2023 22:26:07 +0000
Received: by hermes--production-ne1-574d4b7954-q7frw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 887c9a207356482ed8f5abb20366266f;
          Mon, 05 Jun 2023 22:26:03 +0000 (UTC)
Message-ID: <24dcbfec-1527-ab14-9726-ca91d68f35d4@schaufler-ca.com>
Date: Mon, 5 Jun 2023 15:26:01 -0700
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
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAEf4BzZ5adUcs1qaHx34ZuXMyG6ByczyUqpFKq=+CtxPHYgEVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21516 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/5/2023 1:41 PM, Andrii Nakryiko wrote:
> On Fri, Jun 2, 2023 at 8:55 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 6/2/2023 7:59 AM, Andrii Nakryiko wrote:
>>> *Resending with trimmed CC list because original version didn't make it to
>>> the mailing list.*
>>>
>>> This patch set introduces new BPF object, BPF token, which allows to delegate
>>> a subset of BPF functionality from privileged system-wide daemon (e.g.,
>>> systemd or any other container manager) to a *trusted* unprivileged
>>> application. Trust is the key here. This functionality is not about allowing
>>> unconditional unprivileged BPF usage. Establishing trust, though, is
>>> completely up to the discretion of respective privileged application that
>>> would create a BPF token.
>> Token based privilege has a number of well understood weaknesses,
>> none of which I see addressed here. I also have a real problem with
> Can you please provide some more details about those weaknesses? Hard
> to respond without knowing exactly what we are talking about.

Privileged Process (PP) sends a Token to Trusted Process (TP).
TP sends the Token along to Untrusted Process, which performs nefarious
deeds.

Privileged Process (PP) sends a Token to Trusted Process (TP).
TP uses Token, and then saves it in its toolbox. PP later sends
TP a different Token. TP realizes that with the combination of
Tokens it now has it can do considerably more than what PP
intended in either of the cases it sent Token for. TP performs
nefarious deeds.

Granted, in both cases TP does not deserve to be trusted. 
Because TP does not run with privilege of its own, it is not
treated with the same level of caution as it would be if it did.

Privileged Process (PP) sends a Token to what it thinks is a Trusted
Process (TP) but is in fact an Imposter Process (IP) that has been
enabled on the system using any number of K33L techniques.

I don't see anything that ensures that PP communicates Tokens only
to TP, nor any criteria for "trust" are met.

Those are the issues I'm most familiar with, although I believe
there are others.

>> the notion of "trusted unprivileged" where trust is established by
>> a user space application. Ignoring the possibility of malicious code
>> for the moment, the opportunity for accidental privilege leakage is
>> huge. It would be trivial (and tempting) to create a privileged BPF
>> "shell" that would then be allowed to "trust" any application and
>> run it with privilege by passing it a token.
> Right now most BPF applications are running as real root in
> production. Users have to trust such applications to not do anything
> bad with their full root capabilities. How it is done depends on
> specific production and organizational setups, and could be code
> reviewing, audits, LSM, etc. So in that sense BPF token doesn't make
> things worse. And it actually allows us to improve the situation by
> creating and sharing more restrictive BPF tokens that limit what bpf()
> syscall parts are allowed to be used.
>
>>> The main motivation for BPF token is a desire to enable containerized
>>> BPF applications to be used together with user namespaces. This is currently
>>> impossible, as CAP_BPF, required for BPF subsystem usage, cannot be namespaced
>>> or sandboxed, as a general rule. E.g., tracing BPF programs, thanks to BPF
>>> helpers like bpf_probe_read_kernel() and bpf_probe_read_user() can safely read
>>> arbitrary memory, and it's impossible to ensure that they only read memory of
>>> processes belonging to any given namespace. This means that it's impossible to
>>> have namespace-aware CAP_BPF capability, and as such another mechanism to
>>> allow safe usage of BPF functionality is necessary. BPF token and delegation
>>> of it to a trusted unprivileged applications is such mechanism. Kernel makes
>>> no assumption about what "trusted" constitutes in any particular case, and
>>> it's up to specific privileged applications and their surrounding
>>> infrastructure to decide that. What kernel provides is a set of APIs to create
>>> and tune BPF token, and pass it around to privileged BPF commands that are
>>> creating new BPF objects like BPF programs, BPF maps, etc.
>>>
>>> Previous attempt at addressing this very same problem ([0]) attempted to
>>> utilize authoritative LSM approach, but was conclusively rejected by upstream
>>> LSM maintainers. BPF token concept is not changing anything about LSM
>>> approach, but can be combined with LSM hooks for very fine-grained security
>>> policy. Some ideas about making BPF token more convenient to use with LSM (in
>>> particular custom BPF LSM programs) was briefly described in recent LSF/MM/BPF
>>> 2023 presentation ([1]). E.g., an ability to specify user-provided data
>>> (context), which in combination with BPF LSM would allow implementing a very
>>> dynamic and fine-granular custom security policies on top of BPF token. In the
>>> interest of minimizing API surface area discussions this is going to be
>>> added in follow up patches, as it's not essential to the fundamental concept
>>> of delegatable BPF token.
>>>
>>> It should be noted that BPF token is conceptually quite similar to the idea of
>>> /dev/bpf device file, proposed by Song a while ago ([2]). The biggest
>>> difference is the idea of using virtual anon_inode file to hold BPF token and
>>> allowing multiple independent instances of them, each with its own set of
>>> restrictions. BPF pinning solves the problem of exposing such BPF token
>>> through file system (BPF FS, in this case) for cases where transferring FDs
>>> over Unix domain sockets is not convenient. And also, crucially, BPF token
>>> approach is not using any special stateful task-scoped flags. Instead, bpf()
>>> syscall accepts token_fd parameters explicitly for each relevant BPF command.
>>> This addresses main concerns brought up during the /dev/bpf discussion, and
>>> fits better with overall BPF subsystem design.
>>>
>>> This patch set adds a basic minimum of functionality to make BPF token useful
>>> and to discuss API and functionality. Currently only low-level libbpf APIs
>>> support passing BPF token around, allowing to test kernel functionality, but
>>> for the most part is not sufficient for real-world applications, which
>>> typically use high-level libbpf APIs based on `struct bpf_object` type. This
>>> was done with the intent to limit the size of patch set and concentrate on
>>> mostly kernel-side changes. All the necessary plumbing for libbpf will be sent
>>> as a separate follow up patch set kernel support makes it upstream.
>>>
>>> Another part that should happen once kernel-side BPF token is established, is
>>> a set of conventions between applications (e.g., systemd), tools (e.g.,
>>> bpftool), and libraries (e.g., libbpf) about sharing BPF tokens through BPF FS
>>> at well-defined locations to allow applications take advantage of this in
>>> automatic fashion without explicit code changes on BPF application's side.
>>> But I'd like to postpone this discussion to after BPF token concept lands.
>>>
>>>   [0] https://lore.kernel.org/bpf/20230412043300.360803-1-andrii@kernel.org/
>>>   [1] http://vger.kernel.org/bpfconf2023_material/Trusted_unprivileged_BPF_LSFMM2023.pdf
>>>   [2] https://lore.kernel.org/bpf/20190627201923.2589391-2-songliubraving@fb.com/
>>>
>>> Andrii Nakryiko (18):
>>>   bpf: introduce BPF token object
>>>   libbpf: add bpf_token_create() API
>>>   selftests/bpf: add BPF_TOKEN_CREATE test
>>>   bpf: move unprivileged checks into map_create() and bpf_prog_load()
>>>   bpf: inline map creation logic in map_create() function
>>>   bpf: centralize permissions checks for all BPF map types
>>>   bpf: add BPF token support to BPF_MAP_CREATE command
>>>   libbpf: add BPF token support to bpf_map_create() API
>>>   selftests/bpf: add BPF token-enabled test for BPF_MAP_CREATE command
>>>   bpf: add BPF token support to BPF_BTF_LOAD command
>>>   libbpf: add BPF token support to bpf_btf_load() API
>>>   selftests/bpf: add BPF token-enabled BPF_BTF_LOAD selftest
>>>   bpf: keep BPF_PROG_LOAD permission checks clear of validations
>>>   bpf: add BPF token support to BPF_PROG_LOAD command
>>>   bpf: take into account BPF token when fetching helper protos
>>>   bpf: consistenly use BPF token throughout BPF verifier logic
>>>   libbpf: add BPF token support to bpf_prog_load() API
>>>   selftests/bpf: add BPF token-enabled BPF_PROG_LOAD tests
>>>
>>>  drivers/media/rc/bpf-lirc.c                   |   2 +-
>>>  include/linux/bpf.h                           |  66 ++-
>>>  include/linux/filter.h                        |   2 +-
>>>  include/uapi/linux/bpf.h                      |  74 +++
>>>  kernel/bpf/Makefile                           |   2 +-
>>>  kernel/bpf/arraymap.c                         |   2 +-
>>>  kernel/bpf/bloom_filter.c                     |   3 -
>>>  kernel/bpf/bpf_local_storage.c                |   3 -
>>>  kernel/bpf/bpf_struct_ops.c                   |   3 -
>>>  kernel/bpf/cgroup.c                           |   6 +-
>>>  kernel/bpf/core.c                             |   3 +-
>>>  kernel/bpf/cpumap.c                           |   4 -
>>>  kernel/bpf/devmap.c                           |   3 -
>>>  kernel/bpf/hashtab.c                          |   6 -
>>>  kernel/bpf/helpers.c                          |   6 +-
>>>  kernel/bpf/inode.c                            |  26 ++
>>>  kernel/bpf/lpm_trie.c                         |   3 -
>>>  kernel/bpf/queue_stack_maps.c                 |   4 -
>>>  kernel/bpf/reuseport_array.c                  |   3 -
>>>  kernel/bpf/stackmap.c                         |   3 -
>>>  kernel/bpf/syscall.c                          | 429 ++++++++++++++----
>>>  kernel/bpf/token.c                            | 141 ++++++
>>>  kernel/bpf/verifier.c                         |  13 +-
>>>  kernel/trace/bpf_trace.c                      |   2 +-
>>>  net/core/filter.c                             |  36 +-
>>>  net/core/sock_map.c                           |   4 -
>>>  net/ipv4/bpf_tcp_ca.c                         |   2 +-
>>>  net/netfilter/nf_bpf_link.c                   |   2 +-
>>>  net/xdp/xskmap.c                              |   4 -
>>>  tools/include/uapi/linux/bpf.h                |  74 +++
>>>  tools/lib/bpf/bpf.c                           |  32 +-
>>>  tools/lib/bpf/bpf.h                           |  24 +-
>>>  tools/lib/bpf/libbpf.map                      |   1 +
>>>  .../selftests/bpf/prog_tests/libbpf_probes.c  |   4 +
>>>  .../selftests/bpf/prog_tests/libbpf_str.c     |   6 +
>>>  .../testing/selftests/bpf/prog_tests/token.c  | 282 ++++++++++++
>>>  .../bpf/prog_tests/unpriv_bpf_disabled.c      |   6 +-
>>>  37 files changed, 1098 insertions(+), 188 deletions(-)
>>>  create mode 100644 kernel/bpf/token.c
>>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/token.c
>>>

