Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0FC6067F1
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 20:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiJTSJT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 14:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiJTSIe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 14:08:34 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5321615A95C
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 11:08:16 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id q3-20020a17090311c300b0017898180dddso68968plh.0
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 11:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K4RkLwLrBw4dsUFMcXbIQHoxbFJ2lLCPDiTt8Wszq+s=;
        b=r3OrtrbF1KP4wYRrXIXYR0/HwC/SRKc/9ZBvoloqYKFyOdHF1yfArRhQBxua4NMNzv
         dJ/DCNIbFtGbyzLve63B4A5XAYwaNvhP8XwnEpCf0+EwLNc8vhPSt78Ll/3Qrb6bspWF
         xcpub3fLpQWLPGKLGvY9AyculleMG09eCWGJXJxFSuJN3wYu1eHiDq+02N6avp7xqZtU
         cM1GQV2/XKPb83OPjD3vAU+c0HG0h1QU6SWkGqdLaAgdCsisfhG+jA9uE5pXi1cjBNtl
         Q03/7Tge0LyGTBxbgGQUG4HoLTCz0Ck3tILK0cb+HAHfsxCf5ZOfesfYJppOYD5u34y7
         +ArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4RkLwLrBw4dsUFMcXbIQHoxbFJ2lLCPDiTt8Wszq+s=;
        b=m+obpgkRBqftz9fodC2/UItnGEIeblc67GaDe69wD/+FTRjdHrzWgXTm4S6FjBy8lW
         syNaCPl6LWJsnAKxMRx0jcqqVzf4k5drjTmkHIBpPVuGH2FfCpLEJ1fE6e5hGFpG6GhS
         oTfWPV08O5JUVtUJob4YQVlHZJFK1cHhpH0pluh55RlOFqzTK5RZkXDxfuWYPO91hoIZ
         SzIZKWZ+7rmLOf6Ebz/sFoQZhdBJMdvXgJFDQdtarA3FXIDtFcwcJjDXGAlvfzzAvqLN
         p0ppp3aZjtzlf4skCyEawwphHAlQ2Vbov8VuresILkazCsHjCJF8CmtpXSt4Tb/cMX9I
         wHxw==
X-Gm-Message-State: ACrzQf13CnZFwFU9QYV7p4SOdOa12TyV3VbHxWRvVFU4X8495COP2j0q
        4VW9mOdQVIBX68a/oRHWcdLwfB4=
X-Google-Smtp-Source: AMsMyM5c2GYNenOjseANa7wCKuxZ5fMhLQSds05W7TQV8IjUrXMjlzZdIHCionRo7cRwGtJLXiG90Ac=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:5996:b0:203:1640:2dbf with SMTP id
 l22-20020a17090a599600b0020316402dbfmr17864573pji.150.1666289278344; Thu, 20
 Oct 2022 11:07:58 -0700 (PDT)
Date:   Thu, 20 Oct 2022 11:07:56 -0700
In-Reply-To: <1666235134-562-1-git-send-email-wangyufen@huawei.com>
Mime-Version: 1.0
References: <1666235134-562-1-git-send-email-wangyufen@huawei.com>
Message-ID: <Y1GOfIXzOt61uMo9@google.com>
Subject: Re: [bpf-next] selftests/bpf: fix missing BPF object files
From:   sdf@google.com
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, mykolal@fb.com,
        martin.lau@linux.dev, ast@kernel.org, deso@posteo.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/20, Wang Yufen wrote:
> After commit afef88e65554 ("selftests/bpf: Store BPF object files with
> .bpf.o extension"), we should use *.bpf.o instead of *.o.

> In addition, use the BPF_FILE variable to save the BPF object file name,
> which can be better identified and modified.

> Fixes: afef88e65554 ("selftests/bpf: Store BPF object files with .bpf.o  
> extension")
> Signed-off-by: Wang Yufen <wangyufen@huawei.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

I wish these were a part of test_progs to be exercised by the CI :-(

> ---
>   tools/testing/selftests/bpf/test_bpftool_metadata.sh |  7 +++++--
>   tools/testing/selftests/bpf/test_flow_dissector.sh   |  6 ++++--
>   tools/testing/selftests/bpf/test_lwt_ip_encap.sh     | 17  
> +++++++++--------
>   tools/testing/selftests/bpf/test_lwt_seg6local.sh    |  9 +++++----
>   tools/testing/selftests/bpf/test_tc_edt.sh           |  3 ++-
>   tools/testing/selftests/bpf/test_tc_tunnel.sh        |  5 +++--
>   tools/testing/selftests/bpf/test_tunnel.sh           |  5 +++--
>   tools/testing/selftests/bpf/test_xdp_meta.sh         |  9 +++++----
>   tools/testing/selftests/bpf/test_xdp_vlan.sh         |  8 ++++----
>   9 files changed, 40 insertions(+), 29 deletions(-)

> diff --git a/tools/testing/selftests/bpf/test_bpftool_metadata.sh  
> b/tools/testing/selftests/bpf/test_bpftool_metadata.sh
> index 1bf81b4..b552069 100755
> --- a/tools/testing/selftests/bpf/test_bpftool_metadata.sh
> +++ b/tools/testing/selftests/bpf/test_bpftool_metadata.sh
> @@ -4,6 +4,9 @@
>   # Kselftest framework requirement - SKIP code is 4.
>   ksft_skip=4

> +BPF_FILE_USED="metadata_used.bpf.o"
> +BPF_FILE_UNUSED="metadata_unused.bpf.o"
> +
>   TESTNAME=bpftool_metadata
>   BPF_FS=$(awk '$3 == "bpf" {print $2; exit}' /proc/mounts)
>   BPF_DIR=$BPF_FS/test_$TESTNAME
> @@ -55,7 +58,7 @@ mkdir $BPF_DIR

>   trap cleanup EXIT

> -bpftool prog load metadata_unused.o $BPF_DIR/unused
> +bpftool prog load $BPF_FILE_UNUSED $BPF_DIR/unused

>   METADATA_PLAIN="$(bpftool prog)"
>   echo "$METADATA_PLAIN" | grep 'a = "foo"' > /dev/null
> @@ -67,7 +70,7 @@ bpftool map | grep 'metadata.rodata' > /dev/null

>   rm $BPF_DIR/unused

> -bpftool prog load metadata_used.o $BPF_DIR/used
> +bpftool prog load $BPF_FILE_USED $BPF_DIR/used

>   METADATA_PLAIN="$(bpftool prog)"
>   echo "$METADATA_PLAIN" | grep 'a = "bar"' > /dev/null
> diff --git a/tools/testing/selftests/bpf/test_flow_dissector.sh  
> b/tools/testing/selftests/bpf/test_flow_dissector.sh
> index 5303ce0..4b298863 100755
> --- a/tools/testing/selftests/bpf/test_flow_dissector.sh
> +++ b/tools/testing/selftests/bpf/test_flow_dissector.sh
> @@ -2,6 +2,8 @@
>   # SPDX-License-Identifier: GPL-2.0
>   #
>   # Load BPF flow dissector and verify it correctly dissects traffic
> +
> +BPF_FILE="bpf_flow.bpf.o"
>   export TESTNAME=test_flow_dissector
>   unmount=0

> @@ -22,7 +24,7 @@ if [[ -z $(ip netns identify $$) ]]; then
>   	if bpftool="$(which bpftool)"; then
>   		echo "Testing global flow dissector..."

> -		$bpftool prog loadall ./bpf_flow.o /sys/fs/bpf/flow \
> +		$bpftool prog loadall $BPF_FILE /sys/fs/bpf/flow \
>   			type flow_dissector

>   		if ! unshare --net $bpftool prog attach pinned \
> @@ -95,7 +97,7 @@ else
>   fi

>   # Attach BPF program
> -./flow_dissector_load -p bpf_flow.o -s _dissect
> +./flow_dissector_load -p $BPF_FILE -s _dissect

>   # Setup
>   tc qdisc add dev lo ingress
> diff --git a/tools/testing/selftests/bpf/test_lwt_ip_encap.sh  
> b/tools/testing/selftests/bpf/test_lwt_ip_encap.sh
> index 6c69c42..1e565f4 100755
> --- a/tools/testing/selftests/bpf/test_lwt_ip_encap.sh
> +++ b/tools/testing/selftests/bpf/test_lwt_ip_encap.sh
> @@ -38,6 +38,7 @@
>   #       ping: SRC->[encap at veth2:ingress]->GRE:decap->DST
>   #       ping replies go DST->SRC directly

> +BPF_FILE="test_lwt_ip_encap.bpf.o"
>   if [[ $EUID -ne 0 ]]; then
>   	echo "This script must be run as root"
>   	echo "FAIL"
> @@ -373,14 +374,14 @@ test_egress()
>   	# install replacement routes (LWT/eBPF), pings succeed
>   	if [ "${ENCAP}" == "IPv4" ] ; then
>   		ip -netns ${NS1} route add ${IPv4_DST} encap bpf xmit obj \
> -			test_lwt_ip_encap.o sec encap_gre dev veth1 ${VRF}
> +			${BPF_FILE} sec encap_gre dev veth1 ${VRF}
>   		ip -netns ${NS1} -6 route add ${IPv6_DST} encap bpf xmit obj \
> -			test_lwt_ip_encap.o sec encap_gre dev veth1 ${VRF}
> +			${BPF_FILE} sec encap_gre dev veth1 ${VRF}
>   	elif [ "${ENCAP}" == "IPv6" ] ; then
>   		ip -netns ${NS1} route add ${IPv4_DST} encap bpf xmit obj \
> -			test_lwt_ip_encap.o sec encap_gre6 dev veth1 ${VRF}
> +			${BPF_FILE} sec encap_gre6 dev veth1 ${VRF}
>   		ip -netns ${NS1} -6 route add ${IPv6_DST} encap bpf xmit obj \
> -			test_lwt_ip_encap.o sec encap_gre6 dev veth1 ${VRF}
> +			${BPF_FILE} sec encap_gre6 dev veth1 ${VRF}
>   	else
>   		echo "    unknown encap ${ENCAP}"
>   		TEST_STATUS=1
> @@ -431,14 +432,14 @@ test_ingress()
>   	# install replacement routes (LWT/eBPF), pings succeed
>   	if [ "${ENCAP}" == "IPv4" ] ; then
>   		ip -netns ${NS2} route add ${IPv4_DST} encap bpf in obj \
> -			test_lwt_ip_encap.o sec encap_gre dev veth2 ${VRF}
> +			${BPF_FILE} sec encap_gre dev veth2 ${VRF}
>   		ip -netns ${NS2} -6 route add ${IPv6_DST} encap bpf in obj \
> -			test_lwt_ip_encap.o sec encap_gre dev veth2 ${VRF}
> +			${BPF_FILE} sec encap_gre dev veth2 ${VRF}
>   	elif [ "${ENCAP}" == "IPv6" ] ; then
>   		ip -netns ${NS2} route add ${IPv4_DST} encap bpf in obj \
> -			test_lwt_ip_encap.o sec encap_gre6 dev veth2 ${VRF}
> +			${BPF_FILE} sec encap_gre6 dev veth2 ${VRF}
>   		ip -netns ${NS2} -6 route add ${IPv6_DST} encap bpf in obj \
> -			test_lwt_ip_encap.o sec encap_gre6 dev veth2 ${VRF}
> +			${BPF_FILE} sec encap_gre6 dev veth2 ${VRF}
>   	else
>   		echo "FAIL: unknown encap ${ENCAP}"
>   		TEST_STATUS=1
> diff --git a/tools/testing/selftests/bpf/test_lwt_seg6local.sh  
> b/tools/testing/selftests/bpf/test_lwt_seg6local.sh
> index 826f4423..0efea22 100755
> --- a/tools/testing/selftests/bpf/test_lwt_seg6local.sh
> +++ b/tools/testing/selftests/bpf/test_lwt_seg6local.sh
> @@ -23,6 +23,7 @@

>   # Kselftest framework requirement - SKIP code is 4.
>   ksft_skip=4
> +BPF_FILE="test_lwt_seg6local.bpf.o"
>   readonly NS1="ns1-$(mktemp -u XXXXXX)"
>   readonly NS2="ns2-$(mktemp -u XXXXXX)"
>   readonly NS3="ns3-$(mktemp -u XXXXXX)"
> @@ -117,18 +118,18 @@ ip netns exec ${NS6} ip -6 addr add fb00::109/16  
> dev veth10 scope link
>   ip netns exec ${NS1} ip -6 addr add fb00::1/16 dev lo
>   ip netns exec ${NS1} ip -6 route add fb00::6 dev veth1 via fb00::21

> -ip netns exec ${NS2} ip -6 route add fb00::6 encap bpf in obj  
> test_lwt_seg6local.o sec encap_srh dev veth2
> +ip netns exec ${NS2} ip -6 route add fb00::6 encap bpf in obj  
> ${BPF_FILE} sec encap_srh dev veth2
>   ip netns exec ${NS2} ip -6 route add fd00::1 dev veth3 via fb00::43  
> scope link

>   ip netns exec ${NS3} ip -6 route add fc42::1 dev veth5 via fb00::65
> -ip netns exec ${NS3} ip -6 route add fd00::1 encap seg6local action  
> End.BPF endpoint obj test_lwt_seg6local.o sec add_egr_x dev veth4
> +ip netns exec ${NS3} ip -6 route add fd00::1 encap seg6local action  
> End.BPF endpoint obj ${BPF_FILE} sec add_egr_x dev veth4

> -ip netns exec ${NS4} ip -6 route add fd00::2 encap seg6local action  
> End.BPF endpoint obj test_lwt_seg6local.o sec pop_egr dev veth6
> +ip netns exec ${NS4} ip -6 route add fd00::2 encap seg6local action  
> End.BPF endpoint obj ${BPF_FILE} sec pop_egr dev veth6
>   ip netns exec ${NS4} ip -6 addr add fc42::1 dev lo
>   ip netns exec ${NS4} ip -6 route add fd00::3 dev veth7 via fb00::87

>   ip netns exec ${NS5} ip -6 route add fd00::4 table 117 dev veth9 via  
> fb00::109
> -ip netns exec ${NS5} ip -6 route add fd00::3 encap seg6local action  
> End.BPF endpoint obj test_lwt_seg6local.o sec inspect_t dev veth8
> +ip netns exec ${NS5} ip -6 route add fd00::3 encap seg6local action  
> End.BPF endpoint obj ${BPF_FILE} sec inspect_t dev veth8

>   ip netns exec ${NS6} ip -6 addr add fb00::6/16 dev lo
>   ip netns exec ${NS6} ip -6 addr add fd00::4/16 dev lo
> diff --git a/tools/testing/selftests/bpf/test_tc_edt.sh  
> b/tools/testing/selftests/bpf/test_tc_edt.sh
> index daa7d1b..76f0bd1 100755
> --- a/tools/testing/selftests/bpf/test_tc_edt.sh
> +++ b/tools/testing/selftests/bpf/test_tc_edt.sh
> @@ -5,6 +5,7 @@
>   # with dst port = 9000 down to 5MBps. Then it measures actual
>   # throughput of the flow.

> +BPF_FILE="test_tc_edt.bpf.o"
>   if [[ $EUID -ne 0 ]]; then
>   	echo "This script must be run as root"
>   	echo "FAIL"
> @@ -54,7 +55,7 @@ ip -netns ${NS_DST} route add ${IP_SRC}/32  dev veth_dst
>   ip netns exec ${NS_SRC} tc qdisc add dev veth_src root fq
>   ip netns exec ${NS_SRC} tc qdisc add dev veth_src clsact
>   ip netns exec ${NS_SRC} tc filter add dev veth_src egress \
> -	bpf da obj test_tc_edt.o sec cls_test
> +	bpf da obj ${BPF_FILE} sec cls_test


>   # start the listener
> diff --git a/tools/testing/selftests/bpf/test_tc_tunnel.sh  
> b/tools/testing/selftests/bpf/test_tc_tunnel.sh
> index 088fcad..334bdfe 100755
> --- a/tools/testing/selftests/bpf/test_tc_tunnel.sh
> +++ b/tools/testing/selftests/bpf/test_tc_tunnel.sh
> @@ -3,6 +3,7 @@
>   #
>   # In-place tunneling

> +BPF_FILE="test_tc_tunnel.bpf.o"
>   # must match the port that the bpf program filters on
>   readonly port=8000

> @@ -196,7 +197,7 @@ verify_data
>   # client can no longer connect
>   ip netns exec "${ns1}" tc qdisc add dev veth1 clsact
>   ip netns exec "${ns1}" tc filter add dev veth1 egress \
> -	bpf direct-action object-file ./test_tc_tunnel.o \
> +	bpf direct-action object-file ${BPF_FILE} \
>   	section "encap_${tuntype}_${mac}"
>   echo "test bpf encap without decap (expect failure)"
>   server_listen
> @@ -296,7 +297,7 @@ fi
>   ip netns exec "${ns2}" ip link del dev testtun0
>   ip netns exec "${ns2}" tc qdisc add dev veth2 clsact
>   ip netns exec "${ns2}" tc filter add dev veth2 ingress \
> -	bpf direct-action object-file ./test_tc_tunnel.o section decap
> +	bpf direct-action object-file ${BPF_FILE} section decap
>   echo "test bpf encap with bpf decap"
>   client_connect
>   verify_data
> diff --git a/tools/testing/selftests/bpf/test_tunnel.sh  
> b/tools/testing/selftests/bpf/test_tunnel.sh
> index e9ebc67..2eaedc1 100755
> --- a/tools/testing/selftests/bpf/test_tunnel.sh
> +++ b/tools/testing/selftests/bpf/test_tunnel.sh
> @@ -45,6 +45,7 @@
>   # 5) Tunnel protocol handler, ex: vxlan_rcv, decap the packet
>   # 6) Forward the packet to the overlay tnl dev

> +BPF_FILE="test_tunnel_kern.bpf.o"
>   BPF_PIN_TUNNEL_DIR="/sys/fs/bpf/tc/tunnel"
>   PING_ARG="-c 3 -w 10 -q"
>   ret=0
> @@ -545,7 +546,7 @@ test_xfrm_tunnel()
>   	> /sys/kernel/debug/tracing/trace
>   	setup_xfrm_tunnel
>   	mkdir -p ${BPF_PIN_TUNNEL_DIR}
> -	bpftool prog loadall ./test_tunnel_kern.o ${BPF_PIN_TUNNEL_DIR}
> +	bpftool prog loadall ${BPF_FILE} ${BPF_PIN_TUNNEL_DIR}
>   	tc qdisc add dev veth1 clsact
>   	tc filter add dev veth1 proto ip ingress bpf da object-pinned \
>   		${BPF_PIN_TUNNEL_DIR}/xfrm_get_state
> @@ -572,7 +573,7 @@ attach_bpf()
>   	SET=$2
>   	GET=$3
>   	mkdir -p ${BPF_PIN_TUNNEL_DIR}
> -	bpftool prog loadall ./test_tunnel_kern.o ${BPF_PIN_TUNNEL_DIR}/
> +	bpftool prog loadall ${BPF_FILE} ${BPF_PIN_TUNNEL_DIR}/
>   	tc qdisc add dev $DEV clsact
>   	tc filter add dev $DEV egress bpf da object-pinned  
> ${BPF_PIN_TUNNEL_DIR}/$SET
>   	tc filter add dev $DEV ingress bpf da object-pinned  
> ${BPF_PIN_TUNNEL_DIR}/$GET
> diff --git a/tools/testing/selftests/bpf/test_xdp_meta.sh  
> b/tools/testing/selftests/bpf/test_xdp_meta.sh
> index ea69370..2740322 100755
> --- a/tools/testing/selftests/bpf/test_xdp_meta.sh
> +++ b/tools/testing/selftests/bpf/test_xdp_meta.sh
> @@ -1,5 +1,6 @@
>   #!/bin/sh

> +BPF_FILE="test_xdp_meta.bpf.o"
>   # Kselftest framework requirement - SKIP code is 4.
>   readonly KSFT_SKIP=4
>   readonly NS1="ns1-$(mktemp -u XXXXXX)"
> @@ -42,11 +43,11 @@ ip netns exec ${NS2} ip addr add 10.1.1.22/24 dev  
> veth2
>   ip netns exec ${NS1} tc qdisc add dev veth1 clsact
>   ip netns exec ${NS2} tc qdisc add dev veth2 clsact

> -ip netns exec ${NS1} tc filter add dev veth1 ingress bpf da obj  
> test_xdp_meta.o sec t
> -ip netns exec ${NS2} tc filter add dev veth2 ingress bpf da obj  
> test_xdp_meta.o sec t
> +ip netns exec ${NS1} tc filter add dev veth1 ingress bpf da obj  
> ${BPF_FILE} sec t
> +ip netns exec ${NS2} tc filter add dev veth2 ingress bpf da obj  
> ${BPF_FILE} sec t

> -ip netns exec ${NS1} ip link set dev veth1 xdp obj test_xdp_meta.o sec x
> -ip netns exec ${NS2} ip link set dev veth2 xdp obj test_xdp_meta.o sec x
> +ip netns exec ${NS1} ip link set dev veth1 xdp obj ${BPF_FILE} sec x
> +ip netns exec ${NS2} ip link set dev veth2 xdp obj ${BPF_FILE} sec x

>   ip netns exec ${NS1} ip link set dev veth1 up
>   ip netns exec ${NS2} ip link set dev veth2 up
> diff --git a/tools/testing/selftests/bpf/test_xdp_vlan.sh  
> b/tools/testing/selftests/bpf/test_xdp_vlan.sh
> index 810c407..fbcaa9f 100755
> --- a/tools/testing/selftests/bpf/test_xdp_vlan.sh
> +++ b/tools/testing/selftests/bpf/test_xdp_vlan.sh
> @@ -200,11 +200,11 @@ ip netns exec ${NS2} sh -c 'ping -W 1 -c 1  
> 100.64.41.1 || echo "Success: First p
>   # ----------------------------------------------------------------------
>   # In ns1: ingress use XDP to remove VLAN tags
>   export DEVNS1=veth1
> -export FILE=test_xdp_vlan.o
> +export BPF_FILE=test_xdp_vlan.bpf.o

>   # First test: Remove VLAN by setting VLAN ID 0, using "xdp_vlan_change"
>   export XDP_PROG=xdp_vlan_change
> -ip netns exec ${NS1} ip link set $DEVNS1 $XDP_MODE object $FILE section  
> $XDP_PROG
> +ip netns exec ${NS1} ip link set $DEVNS1 $XDP_MODE object $BPF_FILE  
> section $XDP_PROG

>   # In ns1: egress use TC to add back VLAN tag 4011
>   #  (del cmd)
> @@ -212,7 +212,7 @@ ip netns exec ${NS1} ip link set $DEVNS1 $XDP_MODE  
> object $FILE section $XDP_PRO
>   #
>   ip netns exec ${NS1} tc qdisc add dev $DEVNS1 clsact
>   ip netns exec ${NS1} tc filter add dev $DEVNS1 egress \
> -  prio 1 handle 1 bpf da obj $FILE sec tc_vlan_push
> +  prio 1 handle 1 bpf da obj $BPF_FILE sec tc_vlan_push

>   # Now the namespaces can reach each-other, test with ping:
>   ip netns exec ${NS2} ping -i 0.2 -W 2 -c 2 $IPADDR1
> @@ -226,7 +226,7 @@ ip netns exec ${NS1} ping -i 0.2 -W 2 -c 2 $IPADDR2
>   #
>   export XDP_PROG=xdp_vlan_remove_outer2
>   ip netns exec ${NS1} ip link set $DEVNS1 $XDP_MODE off
> -ip netns exec ${NS1} ip link set $DEVNS1 $XDP_MODE object $FILE section  
> $XDP_PROG
> +ip netns exec ${NS1} ip link set $DEVNS1 $XDP_MODE object $BPF_FILE  
> section $XDP_PROG

>   # Now the namespaces should still be able reach each-other, test with  
> ping:
>   ip netns exec ${NS2} ping -i 0.2 -W 2 -c 2 $IPADDR1
> --
> 1.8.3.1

