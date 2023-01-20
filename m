Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5053F6748AB
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 02:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjATBNU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 20:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjATBNT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 20:13:19 -0500
Received: from sonic305-28.consmr.mail.ne1.yahoo.com (sonic305-28.consmr.mail.ne1.yahoo.com [66.163.185.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CAD9F3B5
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 17:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1674177196; bh=PWiF7VI1pvPfMmzI9UWE2qMd04DIcRMVunfWKdX0zTI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=D4qcjbK74yQVWjXypXFDlW8aQVtrjMhXWogywzZi+d91B2FothfcZWVLtdfS+fIVonLdwi31gf+gfm1GBChCrgPC7aDx0jnJM7Z969WleZjsUbQnehtt/J4seXuyv7kV3SmMcUmfkTSixUQGVTpZ+fIqUTOI6CTdC81Tt6uviIvOn0X8o1/BLHMOgoMoJ0EW6pGE96N94DNAfsZUZT70fly9OPnN/eFNrmN7dVr7B9H0/dkVgDHcrhHt6FglyIU96WyvJr5+URv4qod7Yrs/f8+SPmkXP2P9/tvw6+lzS9Fiy7VB3I+VWPPFbziCR5OVwdde3xgwgqosuf0io1WeMw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1674177196; bh=qNFfTeRVn8o1sKtL9Apy5071YYCztH5qJmVxd13JugE=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=V7kPKWgLiZXZLx7Rmc8el4vPbCzBNtZRtlLkJ2epMXkKWgulXLaXGp+cn1Wbhb0YUpVqGuTZBOmdchQzcTf1g8rCoIMFzAIkXBuKWKsvK8AQKbwz01HeFddFSnORGER2eNUw1N5M6CqSlTK+rDwOoc8jCdcUJUjCAHE/AR2zCV8Te3nWHOnHNs3ppCsF7sWg6xrWMpLQ7OpqlmFHY/8NnNvKurH37b9ZRgYxPkzP73uFOIczfyxWDeP2q0CWSipM2eCgCPhCau7bebTmuTvXk2YE/ndpS4uGxE7J/G7HdS8yVIRLDXbIRQMU8t+BvZ2ZNfwmWaojOJq1TkSA6n2l2w==
X-YMail-OSG: eNIZ8JIVM1liopnK7u9suUY_Sif9jAWeWedcR91DIu0ptyey0ojyJk0UG_imOKG
 gB_qa55A9Th2FY1iEnf8Ori4U5KszUvAfdlNa9RZbWrVs4s.MjOT8PHYTRcKfh9ijjEMqM9C5fM0
 rT4sXNjWyIwwB8nPXNy9zdJhV9r8VOXaw.bOcMU56hFullAzGUBYTpRZ2Db5QjPihBj5DNs8GjEg
 HmAkTybd1hU9h3r5d3ks.iwXxVw_Og_cPz_noxp7nWLr1WosG7UKhlFKofWLIQ5EQTtWj2TGkXW8
 w95WcohtKoM9_XF9Zae.ZTx.KtbJxcUJUJ7v.xhyDGurx5TTfipMxUBYgxvlyCWNORcRmsFXpWrV
 tRDNDzDlLLrpPBnyzqp7xvPERZ_qVn0tdZAhVveSP_OTQO48y0ZKNeuZeYAm20v_Ix0eydF4Tv1K
 la4fwxt4thf8th8wrudHfhDSTzBDjT9XGTq0o_znsbuB4dGMk4bvzZ0FyPj_iUB6AqmKBzlmTzj9
 2kfP83R4ovtM_P5F8jSFJECROYCrdh.X08yHbvDdaZBolT8XsUqhirYVWfkjbrXWAk1VBYufxtnL
 HJ6lNdNAR2JAcZ1JWB1dz56UIUU6leCrqZyQcsU3_8yaoHihaTKIcv4H54mVTye.W8QpKePChkoo
 6gUQ.BgwRI.KerGJvXdvfS_ZUvocrcgrh0DZfal_GScX4kx6ZZ65G2SRtt4Mwr8mb0QlUk830UQW
 7lxRLiwPPOqGBbKh74_qKjeBalS6IyL6qv0SmdB9Y8_5sRdR0qCCqA5VdNPum5v3aAFhr6gS8NQp
 j7GdKrUEA8ir.OSRxEgIopsdVFAW.2JfKsW9cfn6veAp2DggBtgJ_yfMy7vHdGJuSaBGE6EnldUn
 J_WQbOsIgXd53RYtvP0AyG2PMFYvhT1YqVTOQDEmi3xfoBGA.uEbvG2jtNqBNwhnQpcOIIbGdjZY
 j5IWgKtYyPeGMJS345UuoJMMpc8ltcEMMsNY_nDIEUT8Ydfv5WZehAHPJp49xJn2_IIOpAa32m4V
 P7L6B4fz1RlOk_uL_DpUYBM4uQJPvx45m2rL57pMBDKLkt7khqKuykYC8Vo0EumRPdG3v8ZVz0g5
 up3AmQDbgI_Lh6IPmbnVSPg_DZwj21qoOdXUiZPqdabo5JBtU0hB3sknBWLhaTZysKhuB5JrNEzh
 A4Ygmql9FCKIJap6Kk1fgm09NprNh7OB0ZrZ5tjbstfm5.SdATlVNZlciRNcxVEsA5HqqxWM_eQO
 9woqxQKYuzBc5R.P62ywtsLdis_chT5y9UNbsYt2OrsNd3NmkU1j1xqZdMBwRU2EWOpPh9B5tFpt
 vBH6CcZyhlEVI4c.0UkIXsrWBuPCegJTRfbPpKxHmce83BbBeOZccfg3PoNBD9.T.XMfPiCvujbs
 dBkzyfDaHvsz3bqOJoq.DlTlgzmnKGVwPWlGDPjErfiUDTZr0Ijy.s9c2pTdPPIQqSor34x2n7QZ
 KU4kHjLCHOYKkifULhbLOoBPG..3rMZ3jHvfuIsC_OtJlmt4Z_mix.n1POeTx8_XJNNXZMPd0C67
 e.6Yy1J3MRkFQ9WwTXWPd_GSffz_AAEQ3KBa8thrKpAM75Wq3wQeBC0jHIequls5H9CuR_89_R1n
 zRv2bXt8p4371kC_KMoslDirMzxH06vK.V_S4ryBrRUEp9VX.eEP.l6ybEf3zO4PfHMncii3yglL
 jxLJmSc9sWj5jexO5ivrt8k_5WktF8cwp_Ebp7kDSQVNPozxhFIM9FtIwTeilpswosqsscmTGmtm
 .UiSUPE1szk5dTr8nZguVKEV4rYLvppm.0UgoDUeeCZYQKqaA2pw4Fuzwnc2ngne6FSP3LUtEcSA
 WoHPH0IURn16OpP_1gYQOOC3CXbNvuwY.uuJQ8sTQN9g9OXT4.a1jLOXmuTxj7E5bKN6GtkGBSfB
 BFauxmATnspUR_Yik_MLeQ7jbRKb9xVQvHzzqlTHcpDy8XAljOIC78bd69YzpxUbhePnni2M_vHL
 PiBtuDp6bfqwE_MMi6kJVOEluvag287I87NhFBmM1ILESxXnuiweeRTziNvtxbnBgAP1gMGlaYup
 qSrQVuhYY7C587.YkaoSl0eqjMK6BZZmjS96IRnX5gbHPaDW5.oQCRC0DH6g7dpodp05lmrRZcjU
 rhVUuYGfaQmq.GfN78WFtT3__tgK1vERFR71w3I8nwalvTGyoAnL6RVLID_kwRs.m5gDPXAMw5pV
 N3wJnIAjpDFSZWlzz4HXrW_VocWDV2LjAu6lxzUZKQpS25YN_aZgHEV.cHEytRyxiBBuh7ikWUC9
 DODqYyjrc_8s-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 20 Jan 2023 01:13:16 +0000
Received: by hermes--production-ne1-749986b79f-sfndk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c9500df96a050e18d3e1ff2859261def;
          Fri, 20 Jan 2023 01:13:11 +0000 (UTC)
Message-ID: <1e14f68c-90ba-f406-f08c-6d62bbfef6a0@schaufler-ca.com>
Date:   Thu, 19 Jan 2023 17:13:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH bpf-next 0/4] Reduce overhead of LSMs with static calls
To:     KP Singh <kpsingh@kernel.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, paul@paul-moore.com, song@kernel.org,
        revest@chromium.org, keescook@chromium.org, casey@schaufler-ca.com
References: <20230119231033.1307221-1-kpsingh@kernel.org>
Content-Language: en-US
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230119231033.1307221-1-kpsingh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21096 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/19/2023 3:10 PM, KP Singh wrote:
> # Background
>
> LSM hooks (callbacks) are currently invoked as indirect function calls. These
> callbacks are registered into a linked list at boot time as the order of the
> LSMs can be configured on the kernel command line with the "lsm=" command line
> parameter.
>
> Indirect function calls have a high overhead due to retpoline mitigation for
> various speculative execution attacks.
>
> Retpolines remain relevant even with newer generation CPUs as recently
> discovered speculative attacks, like Spectre BHB need Retpolines to mitigate
> against branch history injection and still need to be used in combination with
> newer mitigation features like eIBRS.
>
> This overhead is especially significant for the "bpf" LSM which allows the user
> to implement LSM functionality with eBPF program. In order to facilitate this
> the "bpf" LSM provides a default callback for all LSM hooks. When enabled,
> the "bpf" LSM incurs an unnecessary / avoidable indirect call. This is
> especially bad in OS hot paths (e.g. in the networking stack).
> This overhead prevents the adoption of bpf LSM on performance critical
> systems, and also, in general, slows down all LSMs.
>
> Since we know the address of the enabled LSM callbacks at compile time and only
> the order is determined at boot time,

No quite true. A system with Smack and AppArmor compiled in will only
be allowed to use one or the other.

>  the LSM framework can allocate static
> calls for each of the possible LSM callbacks and these calls can be updated once
> the order is determined at boot.

True if you also provide for the single "major" LSM restriction.

> This series is a respin of the RFC proposed by Paul Renauld (renauld@google.com)
> and Brendan Jackman (jackmanb@google.com) [1]
>
> # Performance improvement
>
> With this patch-set some syscalls with lots of LSM hooks in their path
> benefitted at an average of ~3%. Here are the results of the relevant Unixbench
> system benchmarks with BPF LSM and a major LSM (in this case apparmor) enabled
> with and without the series.
>
> Benchmark                                               Delta(%): (+ is better)
> ===============================================================================
> Execl Throughput                                             +2.9015
> File Write 1024 bufsize 2000 maxblocks                       +5.4196
> Pipe Throughput                                              +7.7434
> Pipe-based Context Switching                                 +3.5118
> Process Creation                                             +0.3552
> Shell Scripts (1 concurrent)                                 +1.7106
> System Call Overhead                                         +3.0067
> System Benchmarks Index Score (Partial Only):                +3.1809

How about socket creation and packet delivery impact? You'll need to
use either SELinux or Smack to get those numbers.

> In the best case, some syscalls like eventfd_create benefitted to about ~10%.
> The full analysis can be viewed at https://kpsingh.ch/lsm-perf
>
> [1] https://lore.kernel.org/linux-security-module/20200820164753.3256899-1-jackmanb@chromium.org/
>
> KP Singh (4):
>   kernel: Add helper macros for loop unrolling
>   security: Generate a header with the count of enabled LSMs
>   security: Replace indirect LSM hook calls with static calls
>   bpf: Only enable BPF LSM hooks when an LSM program is attached
>
>  include/linux/bpf.h              |   1 +
>  include/linux/bpf_lsm.h          |   1 +
>  include/linux/lsm_hooks.h        |  94 +++++++++++--
>  include/linux/unroll.h           |  35 +++++
>  kernel/bpf/trampoline.c          |  29 ++++-
>  scripts/Makefile                 |   1 +
>  scripts/security/.gitignore      |   1 +
>  scripts/security/Makefile        |   4 +
>  scripts/security/gen_lsm_count.c |  57 ++++++++
>  security/Makefile                |  11 ++
>  security/bpf/hooks.c             |  26 +++-
>  security/security.c              | 217 ++++++++++++++++++++-----------
>  12 files changed, 386 insertions(+), 91 deletions(-)
>  create mode 100644 include/linux/unroll.h
>  create mode 100644 scripts/security/.gitignore
>  create mode 100644 scripts/security/Makefile
>  create mode 100644 scripts/security/gen_lsm_count.c
>
