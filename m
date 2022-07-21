Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAE657D76C
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 01:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiGUXpb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 19:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiGUXpa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 19:45:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8939C10FE8
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 16:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658447127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AC2n/A82yx01Ti1I3w8496rsnt6uMK4t3X+Vt7cja9w=;
        b=BLgSYBVVtOdXY3TS9Z9WnLwsEv4Cq8xCsMG3AzNdXOfD7unBiZCVh9qqVaH9Wgh7JFp9A2
        uV4+BYtbqklOXCcZqn2LzohEqQ/73KJ/n2ak+r0i8khOxwj/pjYBY0ZgflLCJA3svSoWId
        CjTkFiEXnWXhTuPN0U9x9cg88syovh8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-2mOxJ8tkPZG8X31SMxOeoQ-1; Thu, 21 Jul 2022 19:45:13 -0400
X-MC-Unique: 2mOxJ8tkPZG8X31SMxOeoQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61BF5185A7A4;
        Thu, 21 Jul 2022 23:45:11 +0000 (UTC)
Received: from localhost (ovpn-12-60.pek2.redhat.com [10.72.12.60])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D91D2166B26;
        Thu, 21 Jul 2022 23:45:09 +0000 (UTC)
Date:   Fri, 22 Jul 2022 07:45:06 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Slark Xiao <slark_xiao@163.com>
Cc:     kafai <kafai@fb.com>, vgoyal <vgoyal@redhat.com>,
        dyoung <dyoung@redhat.com>, ast <ast@kernel.org>,
        daniel <daniel@iogearbox.net>, andrii <andrii@kernel.org>,
        "martin.lau" <martin.lau@linux.dev>, song <song@kernel.org>,
        yhs <yhs@fb.com>, "john.fastabend" <john.fastabend@gmail.com>,
        kpsingh <kpsingh@kernel.org>, sdf <sdf@google.com>,
        haoluo <haoluo@google.com>, jolsa <jolsa@kernel.org>,
        "william.gray" <william.gray@linaro.org>,
        dhowells <dhowells@redhat.com>, peterz <peterz@infradead.org>,
        mingo <mingo@redhat.com>, will <will@kernel.org>,
        longman <longman@redhat.com>,
        "boqun.feng" <boqun.feng@gmail.com>, tglx <tglx@linutronix.de>,
        bigeasy <bigeasy@linutronix.de>,
        kexec <kexec@lists.infradead.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        linux-cachefs <linux-cachefs@redhat.com>
Subject: Re: [PATCH v2] docs: Fix typo in comment
Message-ID: <YtnlAg6Qhf7fwXXW@MiWiFi-R3L-srv>
References: <20220721015605.20651-1-slark_xiao@163.com>
 <20220721154110.fqp7n6f7ij22vayp@kafai-mbp.dhcp.thefacebook.com>
 <21cac0ea.18f.182218041f7.Coremail.slark_xiao@163.com>
 <874jzamhxe.fsf@meer.lwn.net>
 <6ca59494-cc64-d85c-98e8-e9bef2a04c15@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ca59494-cc64-d85c-98e8-e9bef2a04c15@infradead.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/21/22 at 11:40am, Randy Dunlap wrote:
> 
> 
> On 7/21/22 11:36, Jonathan Corbet wrote:
> > "Slark Xiao" <slark_xiao@163.com> writes:
> > 
> >> May I know the maintainer of one subsystem could merge the changes
> >> contains lots of subsystem?  I also know this could be filtered by
> >> grep and sed command, but that patch would have dozens of maintainers
> >> and reviewers.
> > 
> > Certainly I don't think I can merge a patch touching 166 files across
> > the tree.  This will need to be broken down by subsystem, and you may
> > well find that there are some maintainers who don't want to deal with
> > this type of minor fix.
> 
> We have also seen cases where "the the" should be replaced by "then the"
> or some other pair of words, so some of these changes could fall into
> that category.

It's possible. I searched in Documentation and went through each place,
seems no typo of "then the". Below patch should clean up all the 'the the'
typo under Documentation.

From 60cacd213ab24981d16c292667283cf7e74f86b1 Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Fri, 22 Jul 2022 07:26:48 +0800
Subject: [PATCH] Documentation: Fix all occurences of the 'the the' typo
Content-type: text/plain

The fix is done with below command:
sed -i "s/the the /the /g" `git grep -l "the the " Documentation`

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 Documentation/ABI/stable/sysfs-module                         | 2 +-
 Documentation/ABI/testing/sysfs-class-rtrs-client             | 2 +-
 Documentation/ABI/testing/sysfs-class-rtrs-server             | 2 +-
 Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD     | 2 +-
 Documentation/ABI/testing/sysfs-devices-power                 | 2 +-
 Documentation/admin-guide/kdump/vmcoreinfo.rst                | 2 +-
 Documentation/bpf/map_cgroup_storage.rst                      | 4 ++--
 Documentation/core-api/cpu_hotplug.rst                        | 2 +-
 Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt       | 2 +-
 Documentation/devicetree/bindings/clock/ti/davinci/pll.txt    | 2 +-
 Documentation/devicetree/bindings/fpga/fpga-region.txt        | 2 +-
 Documentation/devicetree/bindings/gpio/gpio-pisosr.txt        | 2 +-
 Documentation/devicetree/bindings/net/qcom-emac.txt           | 2 +-
 .../bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml      | 2 +-
 .../devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml   | 2 +-
 .../devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml   | 2 +-
 .../devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml   | 2 +-
 .../devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml      | 2 +-
 Documentation/devicetree/bindings/powerpc/fsl/cpus.txt        | 2 +-
 Documentation/devicetree/bindings/powerpc/opal/power-mgt.txt  | 2 +-
 Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt    | 2 +-
 Documentation/devicetree/bindings/sound/tlv320adcx140.yaml    | 4 ++--
 .../devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml      | 2 +-
 .../devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt  | 2 +-
 Documentation/devicetree/bindings/thermal/rcar-thermal.yaml   | 2 +-
 Documentation/driver-api/isa.rst                              | 2 +-
 Documentation/filesystems/caching/backend-api.rst             | 2 +-
 Documentation/locking/seqlock.rst                             | 2 +-
 Documentation/sphinx/cdomain.py                               | 2 +-
 29 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-module b/Documentation/ABI/stable/sysfs-module
index 560b4a3278df..41b1f16e8795 100644
--- a/Documentation/ABI/stable/sysfs-module
+++ b/Documentation/ABI/stable/sysfs-module
@@ -38,7 +38,7 @@ What:		/sys/module/<MODULENAME>/srcversion
 Date:		Jun 2005
 Description:
 		If the module source has MODULE_VERSION, this file will contain
-		the checksum of the the source code.
+		the checksum of the source code.
 
 What:		/sys/module/<MODULENAME>/version
 Date:		Jun 2005
diff --git a/Documentation/ABI/testing/sysfs-class-rtrs-client b/Documentation/ABI/testing/sysfs-class-rtrs-client
index 49a4157c7bf1..fecc59d1b96f 100644
--- a/Documentation/ABI/testing/sysfs-class-rtrs-client
+++ b/Documentation/ABI/testing/sysfs-class-rtrs-client
@@ -78,7 +78,7 @@ What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/hca_name
 Date:		Feb 2020
 KernelVersion:	5.7
 Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
-Description:	RO, Contains the the name of HCA the connection established on.
+Description:	RO, Contains the name of HCA the connection established on.
 
 What:		/sys/class/rtrs-client/<session-name>/paths/<src@dst>/hca_port
 Date:		Feb 2020
diff --git a/Documentation/ABI/testing/sysfs-class-rtrs-server b/Documentation/ABI/testing/sysfs-class-rtrs-server
index 3b6d5b067df0..b08601d80409 100644
--- a/Documentation/ABI/testing/sysfs-class-rtrs-server
+++ b/Documentation/ABI/testing/sysfs-class-rtrs-server
@@ -24,7 +24,7 @@ What:		/sys/class/rtrs-server/<session-name>/paths/<src@dst>/hca_name
 Date:		Feb 2020
 KernelVersion:	5.7
 Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
-Description:	RO, Contains the the name of HCA the connection established on.
+Description:	RO, Contains the name of HCA the connection established on.
 
 What:		/sys/class/rtrs-server/<session-name>/paths/<src@dst>/hca_port
 Date:		Feb 2020
diff --git a/Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD b/Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD
index f7b360a61b21..bc44bc903bc8 100644
--- a/Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD
+++ b/Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD
@@ -74,7 +74,7 @@ Description:
 
 		Reads also cause the AC alarm timer status to be reset.
 
-		Another way to reset the the status of the AC alarm timer is to
+		Another way to reset the status of the AC alarm timer is to
 		write (the number) 0 to this file.
 
 		If the status return value indicates that the timer has expired,
diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
index 1b2a2d41ff80..54195530e97a 100644
--- a/Documentation/ABI/testing/sysfs-devices-power
+++ b/Documentation/ABI/testing/sysfs-devices-power
@@ -303,5 +303,5 @@ Date:		Apr 2010
 Contact:	Dominik Brodowski <linux@dominikbrodowski.net>
 Description:
 		Reports the runtime PM children usage count of a device, or
-		0 if the the children will be ignored.
+		0 if the children will be ignored.
 
diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 8419019b6a88..6726f439958c 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -200,7 +200,7 @@ prb
 
 A pointer to the printk ringbuffer (struct printk_ringbuffer). This
 may be pointing to the static boot ringbuffer or the dynamically
-allocated ringbuffer, depending on when the the core dump occurred.
+allocated ringbuffer, depending on when the core dump occurred.
 Used by user-space tools to read the active kernel log buffer.
 
 printk_rb_static
diff --git a/Documentation/bpf/map_cgroup_storage.rst b/Documentation/bpf/map_cgroup_storage.rst
index cab9543017bf..8e5fe532c07e 100644
--- a/Documentation/bpf/map_cgroup_storage.rst
+++ b/Documentation/bpf/map_cgroup_storage.rst
@@ -31,7 +31,7 @@ The map uses key of type of either ``__u64 cgroup_inode_id`` or
     };
 
 ``cgroup_inode_id`` is the inode id of the cgroup directory.
-``attach_type`` is the the program's attach type.
+``attach_type`` is the program's attach type.
 
 Linux 5.9 added support for type ``__u64 cgroup_inode_id`` as the key type.
 When this key type is used, then all attach types of the particular cgroup and
@@ -155,7 +155,7 @@ However, the BPF program can still only associate with one map of each type
 ``BPF_MAP_TYPE_CGROUP_STORAGE`` or more than one
 ``BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE``.
 
-In all versions, userspace may use the the attach parameters of cgroup and
+In all versions, userspace may use the attach parameters of cgroup and
 attach type pair in ``struct bpf_cgroup_storage_key`` as the key to the BPF map
 APIs to read or update the storage for a given attachment. For Linux 5.9
 attach type shared storages, only the first value in the struct, cgroup inode
diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
index c6f4ba2fb32d..f75778d37488 100644
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -560,7 +560,7 @@ available:
   * cpuhp_state_remove_instance(state, node)
   * cpuhp_state_remove_instance_nocalls(state, node)
 
-The arguments are the same as for the the cpuhp_state_add_instance*()
+The arguments are the same as for the cpuhp_state_add_instance*()
 variants above.
 
 The functions differ in the way how the installed callbacks are treated:
diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
index 94d50a949be1..c0e3c3a42bea 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
@@ -10,7 +10,7 @@ system, notifying them when a low power state is entered or exited.
 Multiple revisions of the SAW hardware are supported using these Device Nodes.
 SAW2 revisions differ in the register offset and configuration data. Also, the
 same revision of the SAW in different SoCs may have different configuration
-data due the the differences in hardware capabilities. Hence the SoC name, the
+data due the differences in hardware capabilities. Hence the SoC name, the
 version of the SAW hardware in that SoC and the distinction between cpu (big
 or Little) or cache, may be needed to uniquely identify the SAW register
 configuration and initialization data. The compatible string is used to
diff --git a/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt b/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
index 36998e184821..c9894538315b 100644
--- a/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
+++ b/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
@@ -15,7 +15,7 @@ Required properties:
 	- for "ti,da850-pll1", shall be "clksrc"
 
 Optional properties:
-- ti,clkmode-square-wave: Indicates that the the board is supplying a square
+- ti,clkmode-square-wave: Indicates that the board is supplying a square
 	wave input on the OSCIN pin instead of using a crystal oscillator.
 	This property is only valid when compatible = "ti,da850-pll0".
 
diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
index 7d3515264838..6694ef29a267 100644
--- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
+++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
@@ -330,7 +330,7 @@ succeeded.
 
 The Device Tree Overlay will contain:
  * "target-path" or "target"
-   The insertion point where the the contents of the overlay will go into the
+   The insertion point where the contents of the overlay will go into the
    live tree.  target-path is a full path, while target is a phandle.
  * "ranges"
     The address space mapping from processor to FPGA bus(ses).
diff --git a/Documentation/devicetree/bindings/gpio/gpio-pisosr.txt b/Documentation/devicetree/bindings/gpio/gpio-pisosr.txt
index 414a01cdf715..fba3c61f6a5b 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-pisosr.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-pisosr.txt
@@ -14,7 +14,7 @@ Optional properties:
  - ngpios		: Number of used GPIO lines (0..n-1), default is 8.
  - load-gpios		: GPIO pin specifier attached to load enable, this
 			  pin is pulsed before reading from the device to
-			  load input pin values into the the device.
+			  load input pin values into the device.
 
 For other required and optional properties of SPI slave
 nodes please refer to ../spi/spi-bus.txt.
diff --git a/Documentation/devicetree/bindings/net/qcom-emac.txt b/Documentation/devicetree/bindings/net/qcom-emac.txt
index 346e6c7f47b7..e6cb2291471c 100644
--- a/Documentation/devicetree/bindings/net/qcom-emac.txt
+++ b/Documentation/devicetree/bindings/net/qcom-emac.txt
@@ -14,7 +14,7 @@ MAC node:
 - mac-address : The 6-byte MAC address. If present, it is the default
 	MAC address.
 - internal-phy : phandle to the internal PHY node
-- phy-handle : phandle the the external PHY node
+- phy-handle : phandle the external PHY node
 
 Internal PHY node:
 - compatible : Should be "qcom,fsm9900-emac-sgmii" or "qcom,qdf2432-emac-sgmii".
diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
index 4d01f3124e1c..a90fa1baadab 100644
--- a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
+++ b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
@@ -16,7 +16,7 @@ description: |+
   - compatible: Should be the following:
                 "amlogic,meson-gx-hhi-sysctrl", "simple-mfd", "syscon"
 
-  Refer to the the bindings described in
+  Refer to the bindings described in
   Documentation/devicetree/bindings/mfd/syscon.yaml
 
 properties:
diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
index c689bea7ce6e..d3a8911728d0 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
@@ -16,7 +16,7 @@ description: |+
   - compatible:     Should be one of the following:
                     "aspeed,ast2400-scu", "syscon", "simple-mfd"
 
-  Refer to the the bindings described in
+  Refer to the bindings described in
   Documentation/devicetree/bindings/mfd/syscon.yaml
 
 properties:
diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
index 9db904a528ee..5d2c1b1fb7fd 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
@@ -17,7 +17,7 @@ description: |+
   			"aspeed,ast2500-scu", "syscon", "simple-mfd"
   			"aspeed,g5-scu", "syscon", "simple-mfd"
 
-  Refer to the the bindings described in
+  Refer to the bindings described in
   Documentation/devicetree/bindings/mfd/syscon.yaml
 
 properties:
diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
index 3666ac5b6518..e92686d2f062 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
@@ -16,7 +16,7 @@ description: |+
   - compatible: Should be one of the following:
                 "aspeed,ast2600-scu", "syscon", "simple-mfd"
 
-  Refer to the the bindings described in
+  Refer to the bindings described in
   Documentation/devicetree/bindings/mfd/syscon.yaml
 
 properties:
diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
index f005abac7079..4e52ef33a986 100644
--- a/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
+++ b/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
@@ -17,7 +17,7 @@ description: |+
   - compatible: Should be the following:
                 "amlogic,meson-gx-hhi-sysctrl", "simple-mfd", "syscon"
 
-  Refer to the the bindings described in
+  Refer to the bindings described in
   Documentation/devicetree/bindings/mfd/syscon.yaml
 
 properties:
diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpus.txt b/Documentation/devicetree/bindings/powerpc/fsl/cpus.txt
index d63ab1dec16d..801c66069121 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/cpus.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/cpus.txt
@@ -5,7 +5,7 @@ Copyright 2013 Freescale Semiconductor Inc.
 Power Architecture CPUs in Freescale SOCs are represented in device trees as
 per the definition in the Devicetree Specification.
 
-In addition to the the Devicetree Specification definitions, the properties
+In addition to the Devicetree Specification definitions, the properties
 defined below may be present on CPU nodes.
 
 PROPERTIES
diff --git a/Documentation/devicetree/bindings/powerpc/opal/power-mgt.txt b/Documentation/devicetree/bindings/powerpc/opal/power-mgt.txt
index 9d619e955576..d6658d3dd15e 100644
--- a/Documentation/devicetree/bindings/powerpc/opal/power-mgt.txt
+++ b/Documentation/devicetree/bindings/powerpc/opal/power-mgt.txt
@@ -39,7 +39,7 @@ otherwise. The length of all the property arrays must be the same.
 
 - ibm,cpu-idle-state-flags:
 	Array of unsigned 32-bit values containing the values of the
-	flags associated with the the aforementioned idle-states. The
+	flags associated with the aforementioned idle-states. The
 	flag bits are as follows:
 		0x00000001 /* Decrementer would stop */
 		0x00000002 /* Needs timebase restore */
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index b677900b3aae..658f96fbc4fe 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -37,7 +37,7 @@ on the Qualcomm Hexagon core.
 - interrupt-names:
 	Usage: required
 	Value type: <stringlist>
-	Definition: The interrupts needed depends on the the compatible
+	Definition: The interrupts needed depends on the compatible
 		    string:
 	qcom,q6v5-pil:
 	qcom,ipq8074-wcss-pil:
diff --git a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
index 2ad17b361db0..bc2fb1a80ed7 100644
--- a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
+++ b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
@@ -68,9 +68,9 @@ properties:
        array is defined as <PDMIN1 PDMIN2 PDMIN3 PDMIN4>.
 
        0 - (default) Odd channel is latched on the negative edge and even
-       channel is latched on the the positive edge.
+       channel is latched on the positive edge.
        1 - Odd channel is latched on the positive edge and even channel is
-       latched on the the negative edge.
+       latched on the negative edge.
 
        PDMIN1 - PDMCLK latching edge used for channel 1 and 2 data
        PDMIN2 - PDMCLK latching edge used for channel 3 and 4 data
diff --git a/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml b/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
index 1ab5070c751d..89a2c32c0ab2 100644
--- a/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
@@ -16,7 +16,7 @@ description: |+
   - compatible: Should be one of the following:
                 "brcm,bcm2711-avs-monitor", "syscon", "simple-mfd"
 
-  Refer to the the bindings described in
+  Refer to the bindings described in
   Documentation/devicetree/bindings/mfd/syscon.yaml
 
 properties:
diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
index db880e7ed713..aea4a2a178b9 100644
--- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
@@ -96,7 +96,7 @@ critical trip point is reported back to the thermal framework to implement
 software shutdown.
 
 - the "hot" type trip points will be set to SOC_THERM hardware as the throttle
-temperature. Once the the temperature of this thermal zone is higher
+temperature. Once the temperature of this thermal zone is higher
 than it, it will trigger the HW throttle event.
 
 Example :
diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml b/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
index 927de79ab4b5..00dcbdd36144 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
@@ -42,7 +42,7 @@ properties:
     description:
       Address ranges of the thermal registers. If more then one range is given
       the first one must be the common registers followed by each sensor
-      according the the datasheet.
+      according the datasheet.
     minItems: 1
     maxItems: 4
 
diff --git a/Documentation/driver-api/isa.rst b/Documentation/driver-api/isa.rst
index def4a7b690b5..3df1b1696524 100644
--- a/Documentation/driver-api/isa.rst
+++ b/Documentation/driver-api/isa.rst
@@ -100,7 +100,7 @@ I believe platform_data is available for this, but if rather not, moving
 the isa_driver pointer to the private struct isa_dev is ofcourse fine as
 well.
 
-Then, if the the driver did not provide a .match, it matches. If it did,
+Then, if the driver did not provide a .match, it matches. If it did,
 the driver match() method is called to determine a match.
 
 If it did **not** match, dev->platform_data is reset to indicate this to
diff --git a/Documentation/filesystems/caching/backend-api.rst b/Documentation/filesystems/caching/backend-api.rst
index d7507becf674..3a199fc50828 100644
--- a/Documentation/filesystems/caching/backend-api.rst
+++ b/Documentation/filesystems/caching/backend-api.rst
@@ -122,7 +122,7 @@ volumes, calling::
 to tell fscache that a volume has been withdrawn.  This waits for all
 outstanding accesses on the volume to complete before returning.
 
-When the the cache is completely withdrawn, fscache should be notified by
+When the cache is completely withdrawn, fscache should be notified by
 calling::
 
 	void fscache_relinquish_cache(struct fscache_cache *cache);
diff --git a/Documentation/locking/seqlock.rst b/Documentation/locking/seqlock.rst
index 64405e5da63e..bfda1a5fecad 100644
--- a/Documentation/locking/seqlock.rst
+++ b/Documentation/locking/seqlock.rst
@@ -39,7 +39,7 @@ as the writer can invalidate a pointer that the reader is following.
 Sequence counters (``seqcount_t``)
 ==================================
 
-This is the the raw counting mechanism, which does not protect against
+This is the raw counting mechanism, which does not protect against
 multiple writers.  Write side critical sections must thus be serialized
 by an external lock.
 
diff --git a/Documentation/sphinx/cdomain.py b/Documentation/sphinx/cdomain.py
index ca8ac9e59ded..a7d1866e72ff 100644
--- a/Documentation/sphinx/cdomain.py
+++ b/Documentation/sphinx/cdomain.py
@@ -151,7 +151,7 @@ class CObject(Base_CObject):
     def handle_func_like_macro(self, sig, signode):
         u"""Handles signatures of function-like macros.
 
-        If the objtype is 'function' and the the signature ``sig`` is a
+        If the objtype is 'function' and the signature ``sig`` is a
         function-like macro, the name of the macro is returned. Otherwise
         ``False`` is returned.  """
 
-- 
2.34.1

