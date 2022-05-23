Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6DF53176E
	for <lists+bpf@lfdr.de>; Mon, 23 May 2022 22:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiEWUQ1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 16:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbiEWUPy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 16:15:54 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABE4B2251
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 13:14:28 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 0925624002A
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 22:14:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1653336866; bh=9TjCB5t4v/LhUtufK8C4S9+X5/WOvtj4pkPv4/AAW7g=;
        h=Date:From:To:Cc:Subject:From;
        b=jSACMRSaFVbSKXI/R+LElW3HAUPskTNgXUdlf/cJ18JlOkjK5phueNmjV4jwBZib7
         RR6282vMacxPr/sgbSv8r2OWz1/f34BjoGNmyeSJIuS9GIrT2K+wTs22tH2IvBzT+5
         gC3FFmXw6EalpOWZIBGYOSlVGFBFcGlxHeYnyR25IG4RRg5HbpIAwFQzE8Sp+LapCZ
         vs4hEEzkaLRjT1nIUw4SnEUIE2U0xhM1X64ZQuVmE/YOYbkkRK6jLRLEtTpwNiBiPf
         YWeVaSCQ2OtydDq0adAS1DllcR0LnHijbdafTEH1Ez+HAGMaHlwN5Tzun0tjpO0Nt6
         KkCJSd6PSt86A==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4L6T7g1fYRz6tmF;
        Mon, 23 May 2022 22:14:22 +0200 (CEST)
Date:   Mon, 23 May 2022 20:14:19 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
Subject: Re: [PATCH bpf-next v3 09/12] bpftool: Use libbpf_bpf_attach_type_str
Message-ID: <20220523201419.rc6wlwhdhkbunuwn@muellerd-fedora-MJ0AC3F3>
References: <20220519213001.729261-1-deso@posteo.net>
 <20220519213001.729261-10-deso@posteo.net>
 <83796c5c-bb91-bfd0-b02d-e99fa5117a61@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83796c5c-bb91-bfd0-b02d-e99fa5117a61@isovalent.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 23, 2022 at 12:48:09PM +0100, Quentin Monnet wrote:
> 2022-05-19 21:29 UTC+0000 ~ Daniel Müller <deso@posteo.net>
> > This change switches bpftool over to using the recently introduced
> > libbpf_bpf_attach_type_str function instead of maintaining its own
> > string representation for the bpf_attach_type enum.
> > 
> > Note that contrary to other enum types, the variant names that bpftool
> > maps bpf_attach_type to do not follow a simple to follow rule. With
> > bpf_prog_type, for example, the textual representation can easily be
> > inferred by stripping the BPF_PROG_TYPE_ prefix and lowercasing the
> > remaining string. bpf_attach_type violates this rule for various
> > variants.
> > We decided to fix up this deficiency with this change, meaning that
> > bpftool uses the same textual representations as libbpf. Supporting
> > test, completion scripts, and man pages have been adjusted accordingly.
> > However, we did add support for accepting (the now undocumented)
> > original attach type names when they are provided by users.
> > 
> > For the test (test_bpftool_synctypes.py), I have removed the enum
> > representation checks, because we no longer mirror the various enum
> > variant names in bpftool source code. For the man page, help text, and
> > completion script checks we are now using enum definitions from
> > uapi/linux/bpf.h as the source of truth directly.
> > 
> > Signed-off-by: Daniel Müller <deso@posteo.net>
> > ---
> >  .../bpftool/Documentation/bpftool-cgroup.rst  |  16 +-
> >  .../bpftool/Documentation/bpftool-prog.rst    |   5 +-
> >  tools/bpf/bpftool/bash-completion/bpftool     |  18 +-
> >  tools/bpf/bpftool/cgroup.c                    |  49 ++++--
> >  tools/bpf/bpftool/common.c                    |  82 ++++-----
> >  tools/bpf/bpftool/link.c                      |  15 +-
> >  tools/bpf/bpftool/main.h                      |  17 ++
> >  tools/bpf/bpftool/prog.c                      |  26 ++-
> >  .../selftests/bpf/test_bpftool_synctypes.py   | 163 ++++++++----------
> >  9 files changed, 213 insertions(+), 178 deletions(-)
> 
> > diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> > index effe136..c111a5 100644
> > --- a/tools/bpf/bpftool/cgroup.c
> > +++ b/tools/bpf/bpftool/cgroup.c
> > @@ -21,25 +21,39 @@
> >  #define HELP_SPEC_ATTACH_FLAGS						\
> >  	"ATTACH_FLAGS := { multi | override }"
> >  
> > -#define HELP_SPEC_ATTACH_TYPES						       \
> > -	"       ATTACH_TYPE := { ingress | egress | sock_create |\n"	       \
> > -	"                        sock_ops | device | bind4 | bind6 |\n"	       \
> > -	"                        post_bind4 | post_bind6 | connect4 |\n"       \
> > -	"                        connect6 | getpeername4 | getpeername6 |\n"   \
> > -	"                        getsockname4 | getsockname6 | sendmsg4 |\n"   \
> > -	"                        sendmsg6 | recvmsg4 | recvmsg6 |\n"           \
> > -	"                        sysctl | getsockopt | setsockopt |\n"	       \
> > -	"                        sock_release }"
> > +#define HELP_SPEC_ATTACH_TYPES						\
> > +	"       ATTACH_TYPE := { cgroup_inet_ingress | cgroup_inet_egress |\n" \
> > +	"                        cgroup_inet_sock_create | cgroup_sock_ops |\n" \
> > +	"                        cgroup_device | cgroup_inet4_bind |\n" \
> > +	"                        cgroup_inet6_bind | cgroup_inet4_post_bind |\n" \
> > +	"                        cgroup_inet6_post_bind | cgroup_inet4_connect |\n" \
> > +	"                        cgroup_inet6_connect | cgroup_inet4_getpeername |\n" \
> > +	"                        cgroup_inet6_getpeername | cgroup_inet4_getsockname |\n" \
> > +	"                        cgroup_inet6_getsockname | cgroup_udp4_sendmsg |\n" \
> > +	"                        cgroup_udp6_sendmsg | cgroup_udp4_recvmsg |\n" \
> > +	"                        cgroup_udp6_recvmsg | cgroup_sysctl |\n" \
> > +	"                        cgroup_getsockopt | cgroup_setsockopt |\n" \
> > +	"                        cgroup_inet_sock_release }"
> >  
> >  static unsigned int query_flags;
> >  
> >  static enum bpf_attach_type parse_attach_type(const char *str)
> >  {
> > +	const char *attach_type_str;
> >  	enum bpf_attach_type type;
> >  
> > -	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
> > -		if (attach_type_name[type] &&
> > -		    is_prefix(str, attach_type_name[type]))
> > +	for (type = 0; ; type++) {
> > +		attach_type_str = libbpf_bpf_attach_type_str(type);
> > +		if (!attach_type_str)
> > +			break;
> > +		if (is_prefix(str, attach_type_str))
> 
> With so many shared prefixes here, I'm wondering if it would make more
> sense to compare the whole string instead? Otherwise it's hard to guess
> which type “bpftool c a <cgroup> cgroup_ <prog>” will use. At the same
> time we allow prefixing arguments everywhere else, so maybe not worth
> changing it here. Or we could maybe error out if the string length is <=
> strlen("cgroup_")? Let's see for a follow-up maybe.

It is true that it could get confusing, but I'd think it's mostly for write-once
cases where this functionality is used. And there I really see value in
supporting prefixes. I also agree that it's what we do elsewhere. What I think
we should consider fixing, though, is just doing short-circuited first-matches
check. In my opinion we should error out if there are multiple matches instead.
After all, what is first depends on numeric values and these are not really
obvious to the user, I think (and certainly nothing I would want to be bothered
with at this point).

As that is an existing problem, I'd suggest we leave the existing behavior until
we address that.

> > +			return type;
> > +
> > +		/* Also check traditionally used attach type strings. */
> > +		attach_type_str = bpf_attach_type_input_str(type);
> > +		if (!attach_type_str)
> > +			continue;
> > +		if (is_prefix(str, attach_type_str))
> >  			return type;
> >  	}
> >  
> 
> > diff --git a/tools/testing/selftests/bpf/test_bpftool_synctypes.py b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
> > index c0e7acd..0ca3c1 100755
> > --- a/tools/testing/selftests/bpf/test_bpftool_synctypes.py
> > +++ b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
> 
> > @@ -139,21 +139,20 @@ class FileExtractor(object):
> >  
> >      def get_types_from_array(self, array_name):
> >          """
> > -        Search for and parse an array associating names to BPF_* enum members,
> > -        for example:
> > +        Search for and parse an array white-listing BPF_* enum members, for
> 
> The coding style now recommends against the “white-listing”. Maybe
> “[...] a list of allowed BPF_* enum members”?

Ah, good catch, thanks. Will fix it.

[...]

> > @@ -525,34 +521,18 @@ def main():
> >      bashcomp_map_types = bashcomp_info.get_map_types()
> >  
> >      verify(source_map_types, help_map_types,
> > -            f'Comparing {MapFileExtractor.filename} (map_type_name) and {MapFileExtractor.filename} (do_help() TYPE):')
> > +            f'Comparing {BpfHeaderExtractor.filename} (bpf_map_type) and {MapFileExtractor.filename} (do_help() TYPE):')
> >      verify(source_map_types, man_map_types,
> > -            f'Comparing {MapFileExtractor.filename} (map_type_name) and {ManMapExtractor.filename} (TYPE):')
> > +            f'Comparing {BpfHeaderExtractor.filename} (bpf_map_type) and {ManMapExtractor.filename} (TYPE):')
> >      verify(help_map_options, man_map_options,
> >              f'Comparing {MapFileExtractor.filename} (do_help() OPTIONS) and {ManMapExtractor.filename} (OPTIONS):')
> >      verify(source_map_types, bashcomp_map_types,
> > -            f'Comparing {MapFileExtractor.filename} (map_type_name) and {BashcompExtractor.filename} (BPFTOOL_MAP_CREATE_TYPES):')
> > +            f'Comparing {BpfHeaderExtractor.filename} (bpf_map_type) and {BashcompExtractor.filename} (BPFTOOL_MAP_CREATE_TYPES):')
> >  
> >      # Program types (enum)
> >  
> > -    ref = bpf_info.get_prog_types()
> > -
> >      prog_info = ProgFileExtractor()
> 
> Nit: Let's remove "# Program types (enum)" and move "prog_info = ..."
> under "# Attach types"?

Sounds good. Done.

> > -    prog_types = set(prog_info.get_prog_types().keys())
> > -
> > -    verify(ref, prog_types,
> > -            f'Comparing BPF header (enum bpf_prog_type) and {ProgFileExtractor.filename} (prog_type_name):')
> > -
> > -    # Attach types (enum)
> > -
> > -    ref = bpf_info.get_attach_types()
> > -    bpf_info.close()
> > -
> > -    common_info = CommonFileExtractor()
> > -    attach_types = common_info.get_attach_types()
> > -
> > -    verify(ref, attach_types,
> > -            f'Comparing BPF header (enum bpf_attach_type) and {CommonFileExtractor.filename} (attach_type_name):')
> > +    prog_types = bpf_info.get_prog_types()
> 
> It looks like prog_types is unused? I suspect the intention was to
> compare with the program types that bpftool supports in prog.c. Looking
> at this script, it seems there is no such check currently, which is
> likely an ommission on my side. We should add it eventually, but given
> that this is beyond the scope of this PR, let's remove "prog_types" for now?

Yep, unsure how I missed it. Thanks for spotting.

Thanks for the review.

Daniel
