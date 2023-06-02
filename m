Return-Path: <bpf+bounces-1710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBF67206A7
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 17:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81EBF281426
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 15:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A181C749;
	Fri,  2 Jun 2023 15:55:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99BA1B909
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 15:55:47 +0000 (UTC)
Received: from sonic313-14.consmr.mail.ne1.yahoo.com (sonic313-14.consmr.mail.ne1.yahoo.com [66.163.185.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF84018C
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 08:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1685721344; bh=q6WwFCVO7qRZUnasicQku8i6DHbre6ufg1ifkYM0lKA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=XnUJEGyYLdfoMs0HN3VdYmtW0IufniYQkm1BTnUVy6jqTXTbedwCmiqQY0DnYnVnRC1OgA+TUDpC/GO1PRB+Xm9E6R57r8nOLgSlVA1tuVaFZoCnHThghNbIrHr0Ys+J7e4zZvll7cvtHog9C81kHB4fUc1KDYloREyD4SxmYCn3gDkd00v/v4Uy3iVNbcMAxYVcUIzZNCRsbUbrrd35E2/CKfs/TIsDqcmoTeNEdxSJ2N8irdnLuGjgLR1EeQgdoHJHxavfoqGDNBybnrU834LnZJc+b1QOgA2ZQsp5r/SS5gxwb2itzJSAoXtlrOUO022QBV0dfW18zg+IAw8Nag==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1685721344; bh=c5Mg/P6cJSjmDMgjG4t0Rb/nM06KW4GUAm5MFmabDXK=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=szpGQJ7JIOScRpVHYKt/LWAbQAeV00jqBgU4Et3GpDGG60YmFCDa4zLaFJ04RCCBTlsyYX4CHnnGJSZuJ8kgNOskQ6VtuzOqOuUobMe6LhtlPKXfeVHgQ8BO0SdyEhvxwpllz/oYRx6qge+qAuLMnwU0QRtpx8VPpUn1WdJ+MSgZ+ZYUeD1Nhrt3Bkw9AvDKfwU9+8o//eiaaJpl3GKEJXDPymrNH2cE7JKtSnC+G/k80tsyfxJvwLTonn4kc3DNOS85qoIIvLTEjWiDCrlKeqS/n9mFqwKDvfikMOL5fxqACys0nb3g33/VVNNQlQEdTnvQ7XSCFM0y0asIpUXD5w==
X-YMail-OSG: dZDOG_8VM1lO_2DnKweRRrAsVChjpO2yEnB4zUqBGv0SfgFU0PvZ3hUSKg4avq8
 kzeUsy3vGIhTyhimnvzY2cjEPXUdh_T6kLirJ7W1.SE2BdfpgoibDHN.6jL7AwORC9gRebBNsNH0
 PpgUiHDaXQMUD5U7.g_Qsc2S_iIX7oFlR4Yspn9DFmT6oiJfOLrBMIbG5PZ6CBtT99DhvWP0Kye8
 dH6v63DVJjLhFmc3xv6NIQo2rxdroiRvwZSa_ealbsPVr3hEdxWAyAclu8GWSx152mEN.m.8OygU
 1_gs.fsKVTXvSt7KKamyLq2EbelkGVsA0J6Ds7s6SQjFTtP1RhcO8WHUJksvbxq7nHtHpsLgc9bi
 Bwsb1gi86s3MP5SDxIXTY0zyl8Sx0gzRI3wejj_H0usq4T53QSsKx2IB2rMbJ3NtlJF7JABvS6TY
 tahIcWbk3aAC0MmxhLjiePeGmzs2ZpT8Jd_f_ADW1MkN_H6RTdNccuH9pT0JzoyVpoi4mAnLkovy
 N3XNv_xJCoJU0kK8GFeH5zWFNERrUJxznvbZhjkS56vGVFoJXd56ZaDhAuPmaYVQuWdxbJqxbtUq
 64B1Xkp8DKx9LcLU0qeEdDkl068cayLiwEnksz2EbXH0Cm_b6_9ZaTJt9FGlP9fGT802qXJoPSKS
 tQl0ITAazbNyLS_96zYp6gOofswhMND334As9GcXrvHZ8iQveofQXGlwsIs44KYYkp7pWJwICN9T
 mx99dehetzavfyNcCFFVS0qG1IhUVHxkbPFJ1lRz3bSmQhUgVGfmRaWfA_md8Ub4doEQxkdJxjHO
 18ff9Gwo_h8.zKH52v1F9Z7b1FhGAsYV3akftHeGRuGR.DgNXtyU8IE3iMQhct8U6U7Ol2Q5azLL
 22OIA.ir6Dyu8Q_eVxsuEGgn9fGAVtgEa.RM6wLoWHZK.WlqV5YP9D2hFuBTlsatrJbRrpdmPkmq
 WNSHHLm1ZAiAhanD65wtS_47b2pY9Q7N3JOZVvnSvUB3Y_mSGCZD12xm16uFuv0uuFzdCkDW63Ka
 1cMSn3jemkrCqdqR7Cp.j2zRNIszmrhKwvuWSe75LkOIlQHwAf_fcz4NXLY8ujp.BFNSmI6d1RJf
 nnlFEMeEeyXUtm4bRvAKM23SmWuy5pdslOb16.GvP6nwn7oKbneycfquFCtUmR0ffQk8GKm43ZpX
 20wTpeM3B.XVxMMgxR.8YfyzbId6mGOhq_Mztk5lLVBQmprsRq.UeGm3APW64XhApfdAF1h.wp6H
 HDY6JR2xGKRJ4Uc2oIwohoCztbAoKugIzvAjm5azOy3hlxfzEtgrjrI.qPd9o6FTN15CwDYJ1Gvo
 HME0nfD1MkF7gG9SDrKrZ5Aw7ciKwVYukdLB6fcMBMdkzqBWW1J.27YkMXdqfcLki4Gkv7Vdd59U
 c.lanc9eQKVyu.V10_aEK5uctlFoOeZrCUYGuRnOntN5b9e8buyD.uPJBtLRdvYH1XQlkTvBELfL
 IbDA9qRy4fagelv5EgwRwb4aHF6d42f47ziwqilSuttt_.zBe4CF0TQ9L92zqtvYhqKThVb79CLX
 vvsK1o3GCGRj3hGW63b748PZuueiI77g1sc0h0uJ0VoS7zD8dXtU.qpKPBtaBYke._AQxdLh2zVI
 4_JJgew2IONhFRr.fGfL46JJ8p.9H6IOBa5EfHzxG.yaMmNdGUp3Ug36gaTx_vu3rIeiIafCqJbR
 8ptNiDKOgylyBOuJ48JAQ53e5FzOjNC2an2M.kA.46FZBKXSVznEkwGSsXtI5zkvlbsEvyGQAGcg
 evwl7fhiA1jQnXFw_3JWTIRyduWQ6Sutzpbbpv7Ee.Cng7j6POmtiwjRpRwQhGEbtrJZovREr9o5
 QcWrJ5RHaT3Sq5VQn2cpOhygKVBYLtpY6gWcTVd8LGXdyFe9ouu0ReCYmQtJ27cZnqHuYAIcw.8V
 ka5Sm4j992i0BGxsaS0X_YlR4rjIZi7IcKVgZSnid6MSlW4WCl0iiVnWVWYq_pe435QarP0CN7BU
 o__TsA8wbPQrlfPHCkvv1b531dXbJuA2op33WrhM5RL.NFUK8Y8Knb92v.XXrOqSqys4uLEQ7TVy
 kOCGWgHObL_KUCo4QD7Ngc8kGuk4nGfZM6HNG2N5QEAXaHFfoV_tKMHpm60y6D6gF7ZmMwxbJhSP
 qgfRFiCrKQJ6MWqclLjLG_BNfQvAWypqeNdTZ_FTf1arWPz8zGGbhbuR46sApP312qt.XhbavoG_
 0hb3Rr_ReDQ878iVPtKk8hTLbNMLplFmi9dNZUEC0DEEYAGE5D_qNFmnMQuVmWYFUcpfELQMIcj1
 JxTInS.WQGxF0MvjFYg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: d76b7721-fc76-47b7-9df4-7c7a55d236e8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 2 Jun 2023 15:55:44 +0000
Received: by hermes--production-ne1-574d4b7954-6q6hn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID eecbc8c67d9ddf2a1820f11501d996e1;
          Fri, 02 Jun 2023 15:55:40 +0000 (UTC)
Message-ID: <1930272b-cfbe-f366-21ca-e9e7a51347be@schaufler-ca.com>
Date: Fri, 2 Jun 2023 08:55:38 -0700
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
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keescook@chromium.org,
 brauner@kernel.org, lennart@poettering.net, cyphar@cyphar.com,
 luto@kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20230602150011.1657856-1-andrii@kernel.org>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230602150011.1657856-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21495 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/2/2023 7:59 AM, Andrii Nakryiko wrote:
> *Resending with trimmed CC list because original version didn't make it to
> the mailing list.*
>
> This patch set introduces new BPF object, BPF token, which allows to delegate
> a subset of BPF functionality from privileged system-wide daemon (e.g.,
> systemd or any other container manager) to a *trusted* unprivileged
> application. Trust is the key here. This functionality is not about allowing
> unconditional unprivileged BPF usage. Establishing trust, though, is
> completely up to the discretion of respective privileged application that
> would create a BPF token.

Token based privilege has a number of well understood weaknesses,
none of which I see addressed here. I also have a real problem with
the notion of "trusted unprivileged" where trust is established by
a user space application. Ignoring the possibility of malicious code
for the moment, the opportunity for accidental privilege leakage is
huge. It would be trivial (and tempting) to create a privileged BPF
"shell" that would then be allowed to "trust" any application and
run it with privilege by passing it a token.

>
> The main motivation for BPF token is a desire to enable containerized
> BPF applications to be used together with user namespaces. This is currently
> impossible, as CAP_BPF, required for BPF subsystem usage, cannot be namespaced
> or sandboxed, as a general rule. E.g., tracing BPF programs, thanks to BPF
> helpers like bpf_probe_read_kernel() and bpf_probe_read_user() can safely read
> arbitrary memory, and it's impossible to ensure that they only read memory of
> processes belonging to any given namespace. This means that it's impossible to
> have namespace-aware CAP_BPF capability, and as such another mechanism to
> allow safe usage of BPF functionality is necessary. BPF token and delegation
> of it to a trusted unprivileged applications is such mechanism. Kernel makes
> no assumption about what "trusted" constitutes in any particular case, and
> it's up to specific privileged applications and their surrounding
> infrastructure to decide that. What kernel provides is a set of APIs to create
> and tune BPF token, and pass it around to privileged BPF commands that are
> creating new BPF objects like BPF programs, BPF maps, etc.
>
> Previous attempt at addressing this very same problem ([0]) attempted to
> utilize authoritative LSM approach, but was conclusively rejected by upstream
> LSM maintainers. BPF token concept is not changing anything about LSM
> approach, but can be combined with LSM hooks for very fine-grained security
> policy. Some ideas about making BPF token more convenient to use with LSM (in
> particular custom BPF LSM programs) was briefly described in recent LSF/MM/BPF
> 2023 presentation ([1]). E.g., an ability to specify user-provided data
> (context), which in combination with BPF LSM would allow implementing a very
> dynamic and fine-granular custom security policies on top of BPF token. In the
> interest of minimizing API surface area discussions this is going to be
> added in follow up patches, as it's not essential to the fundamental concept
> of delegatable BPF token.
>
> It should be noted that BPF token is conceptually quite similar to the idea of
> /dev/bpf device file, proposed by Song a while ago ([2]). The biggest
> difference is the idea of using virtual anon_inode file to hold BPF token and
> allowing multiple independent instances of them, each with its own set of
> restrictions. BPF pinning solves the problem of exposing such BPF token
> through file system (BPF FS, in this case) for cases where transferring FDs
> over Unix domain sockets is not convenient. And also, crucially, BPF token
> approach is not using any special stateful task-scoped flags. Instead, bpf()
> syscall accepts token_fd parameters explicitly for each relevant BPF command.
> This addresses main concerns brought up during the /dev/bpf discussion, and
> fits better with overall BPF subsystem design.
>
> This patch set adds a basic minimum of functionality to make BPF token useful
> and to discuss API and functionality. Currently only low-level libbpf APIs
> support passing BPF token around, allowing to test kernel functionality, but
> for the most part is not sufficient for real-world applications, which
> typically use high-level libbpf APIs based on `struct bpf_object` type. This
> was done with the intent to limit the size of patch set and concentrate on
> mostly kernel-side changes. All the necessary plumbing for libbpf will be sent
> as a separate follow up patch set kernel support makes it upstream.
>
> Another part that should happen once kernel-side BPF token is established, is
> a set of conventions between applications (e.g., systemd), tools (e.g.,
> bpftool), and libraries (e.g., libbpf) about sharing BPF tokens through BPF FS
> at well-defined locations to allow applications take advantage of this in
> automatic fashion without explicit code changes on BPF application's side.
> But I'd like to postpone this discussion to after BPF token concept lands.
>
>   [0] https://lore.kernel.org/bpf/20230412043300.360803-1-andrii@kernel.org/
>   [1] http://vger.kernel.org/bpfconf2023_material/Trusted_unprivileged_BPF_LSFMM2023.pdf
>   [2] https://lore.kernel.org/bpf/20190627201923.2589391-2-songliubraving@fb.com/
>
> Andrii Nakryiko (18):
>   bpf: introduce BPF token object
>   libbpf: add bpf_token_create() API
>   selftests/bpf: add BPF_TOKEN_CREATE test
>   bpf: move unprivileged checks into map_create() and bpf_prog_load()
>   bpf: inline map creation logic in map_create() function
>   bpf: centralize permissions checks for all BPF map types
>   bpf: add BPF token support to BPF_MAP_CREATE command
>   libbpf: add BPF token support to bpf_map_create() API
>   selftests/bpf: add BPF token-enabled test for BPF_MAP_CREATE command
>   bpf: add BPF token support to BPF_BTF_LOAD command
>   libbpf: add BPF token support to bpf_btf_load() API
>   selftests/bpf: add BPF token-enabled BPF_BTF_LOAD selftest
>   bpf: keep BPF_PROG_LOAD permission checks clear of validations
>   bpf: add BPF token support to BPF_PROG_LOAD command
>   bpf: take into account BPF token when fetching helper protos
>   bpf: consistenly use BPF token throughout BPF verifier logic
>   libbpf: add BPF token support to bpf_prog_load() API
>   selftests/bpf: add BPF token-enabled BPF_PROG_LOAD tests
>
>  drivers/media/rc/bpf-lirc.c                   |   2 +-
>  include/linux/bpf.h                           |  66 ++-
>  include/linux/filter.h                        |   2 +-
>  include/uapi/linux/bpf.h                      |  74 +++
>  kernel/bpf/Makefile                           |   2 +-
>  kernel/bpf/arraymap.c                         |   2 +-
>  kernel/bpf/bloom_filter.c                     |   3 -
>  kernel/bpf/bpf_local_storage.c                |   3 -
>  kernel/bpf/bpf_struct_ops.c                   |   3 -
>  kernel/bpf/cgroup.c                           |   6 +-
>  kernel/bpf/core.c                             |   3 +-
>  kernel/bpf/cpumap.c                           |   4 -
>  kernel/bpf/devmap.c                           |   3 -
>  kernel/bpf/hashtab.c                          |   6 -
>  kernel/bpf/helpers.c                          |   6 +-
>  kernel/bpf/inode.c                            |  26 ++
>  kernel/bpf/lpm_trie.c                         |   3 -
>  kernel/bpf/queue_stack_maps.c                 |   4 -
>  kernel/bpf/reuseport_array.c                  |   3 -
>  kernel/bpf/stackmap.c                         |   3 -
>  kernel/bpf/syscall.c                          | 429 ++++++++++++++----
>  kernel/bpf/token.c                            | 141 ++++++
>  kernel/bpf/verifier.c                         |  13 +-
>  kernel/trace/bpf_trace.c                      |   2 +-
>  net/core/filter.c                             |  36 +-
>  net/core/sock_map.c                           |   4 -
>  net/ipv4/bpf_tcp_ca.c                         |   2 +-
>  net/netfilter/nf_bpf_link.c                   |   2 +-
>  net/xdp/xskmap.c                              |   4 -
>  tools/include/uapi/linux/bpf.h                |  74 +++
>  tools/lib/bpf/bpf.c                           |  32 +-
>  tools/lib/bpf/bpf.h                           |  24 +-
>  tools/lib/bpf/libbpf.map                      |   1 +
>  .../selftests/bpf/prog_tests/libbpf_probes.c  |   4 +
>  .../selftests/bpf/prog_tests/libbpf_str.c     |   6 +
>  .../testing/selftests/bpf/prog_tests/token.c  | 282 ++++++++++++
>  .../bpf/prog_tests/unpriv_bpf_disabled.c      |   6 +-
>  37 files changed, 1098 insertions(+), 188 deletions(-)
>  create mode 100644 kernel/bpf/token.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/token.c
>

