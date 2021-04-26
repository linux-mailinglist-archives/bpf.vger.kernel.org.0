Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B1B36B25D
	for <lists+bpf@lfdr.de>; Mon, 26 Apr 2021 13:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhDZLc7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Apr 2021 07:32:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:49324 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhDZLc7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Apr 2021 07:32:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 04EBBAECD;
        Mon, 26 Apr 2021 11:32:17 +0000 (UTC)
Date:   Mon, 26 Apr 2021 13:32:15 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Yonghong Song <yhs@fb.com>
Cc:     linux-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: linux-next failing build due to missing cubictcp_state symbol
Message-ID: <20210426113215.GM15381@kitsune.suse.cz>
References: <20210423130530.GA6564@kitsune.suse.cz>
 <316e86f9-35cc-36b0-1594-00a09631c736@fb.com>
 <20210423175528.GF6564@kitsune.suse.cz>
 <20210425111545.GL15381@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IpbVkmxF4tDyP/Kb"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210425111545.GL15381@kitsune.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sun, Apr 25, 2021 at 01:15:45PM +0200, Michal Such�nek wrote:
> On Fri, Apr 23, 2021 at 07:55:28PM +0200, Michal Such�nek wrote:
> > On Fri, Apr 23, 2021 at 07:41:29AM -0700, Yonghong Song wrote:
> > > 
> > > 
> > > On 4/23/21 6:05 AM, Michal Such�nek wrote:
> > > > Hello,
> > > > 
> > > > I see this build error in linux-next (config attached).
> > > > 
> > > > [ 4939s]   LD      vmlinux
> > > > [ 4959s]   BTFIDS  vmlinux
> > > > [ 4959s] FAILED unresolved symbol cubictcp_state
> > > > [ 4960s] make[1]: ***
> > > > [/home/abuild/rpmbuild/BUILD/kernel-vanilla-5.12~rc8.next.20210422/linux-5.12-rc8-next-20210422/Makefile:1277:
> > > > vmlinux] Error 255
> > > > [ 4960s] make: *** [../Makefile:222: __sub-make] Error 2
> > > 
> > > Looks like you have DYNAMIC_FTRACE config option enabled already.
> > > Could you try a later version of pahole?
> > 
> > Is this requireent new?
> > 
> > I have pahole 1.20, and master does build without problems.
> > 
> > If newer version is needed can a check be added?
> 
> With dwarves 1.21 some architectures are fixed and some report other
> missing symbol. Definitely an improvenent.
> 
> I see some new type support was added so it makes sense if that type is
> used the new dwarves are needed.

Ok, here is the current failure with dwarves 1.21 on 5.12:

[ 2548s]   LD      vmlinux
[ 2557s]   BTFIDS  vmlinux
[ 2557s] FAILED unresolved symbol vfs_truncate
[ 2558s] make[1]: ***
[/home/abuild/rpmbuild/BUILD/kernel-kvmsmall-5.12.0/linux-5.12/Makefile:1213:
vmlinux] Error 255

Any idea where this one is coming from?

Thanks

Michal

--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=kvmsmall

# CONFIG_AD525X_DPOT is not set
# CONFIG_AGP is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_ALTERA_STAPL is not set
# CONFIG_AMD_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_ATA is not set
# CONFIG_AUXDISPLAY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_BACKLIGHT_CLASS_DEVICE is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_BCMA is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BT is not set
# CONFIG_C2PORT is not set
# CONFIG_CAIF is not set
# CONFIG_CB710_CORE is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DRM is not set
# CONFIG_DS1682 is not set
# CONFIG_DW_DMAC_PCI is not set
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
# CONFIG_EHEA is not set
# CONFIG_EXTCON is not set
# CONFIG_FB is not set
# CONFIG_FIREWIRE is not set
# CONFIG_FPGA is not set
# CONFIG_FSI is not set
# CONFIG_FUSION is not set
# CONFIG_GNSS is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GVE is not set
# CONFIG_HABANA_AI is not set
# CONFIG_HMC6352 is not set
# CONFIG_HP_ILO is not set
# CONFIG_HSI is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HWMON is not set
CONFIG_I2C=m
# CONFIG_I2C_ALGOPCA is not set
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_CHARDEV is not set
# CONFIG_I2C_HELPER_AUTO is not set
# CONFIG_I2C_MUX is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SMBUS is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I3C is not set
# CONFIG_IBM_EMAC is not set
# CONFIG_IBM_EMAC_EMAC4 is not set
# CONFIG_IBM_EMAC_RGMII is not set
# CONFIG_IBM_EMAC_TAH is not set
# CONFIG_IBM_EMAC_ZMII is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_ICS932S401 is not set
# CONFIG_IEEE802154_DRIVERS is not set
# CONFIG_INFINIBAND is not set
# CONFIG_INPUT is not set
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_IPACK_BUS is not set
# CONFIG_ISDN is not set
# CONFIG_ISL29020 is not set
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_LOCALVERSION="-kvmsmall"
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_MACINTOSH_DRIVERS is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MEDIA_SUPPORT is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_MFD_MAX77650 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_STMFX is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_MII=m
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MSPRO_BLOCK is not set
# CONFIG_MS_BLOCK is not set
# CONFIG_MTD is not set
# CONFIG_MUX_MMIO is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NET_DSA is not set
# CONFIG_NET_PTP_CLASSIFY is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
# CONFIG_NET_VENDOR_AGERE is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_NET_VENDOR_AMAZON is not set
# CONFIG_NET_VENDOR_AMD is not set
# CONFIG_NET_VENDOR_AQUANTIA is not set
# CONFIG_NET_VENDOR_ARC is not set
# CONFIG_NET_VENDOR_ATHEROS is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
# CONFIG_NET_VENDOR_BROCADE is not set
# CONFIG_NET_VENDOR_CADENCE is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
# CONFIG_NET_VENDOR_CHELSIO is not set
# CONFIG_NET_VENDOR_CISCO is not set
# CONFIG_NET_VENDOR_CORTINA is not set
# CONFIG_NET_VENDOR_DEC is not set
# CONFIG_NET_VENDOR_DLINK is not set
# CONFIG_NET_VENDOR_EMULEX is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
# CONFIG_NET_VENDOR_HUAWEI is not set
# CONFIG_NET_VENDOR_INTEL is not set
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROSEMI is not set
# CONFIG_NET_VENDOR_MYRI is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_NETERION is not set
# CONFIG_NET_VENDOR_NETRONOME is not set
# CONFIG_NET_VENDOR_NI is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
# CONFIG_NET_VENDOR_OKI is not set
# CONFIG_NET_VENDOR_PACKET_ENGINES is not set
# CONFIG_NET_VENDOR_QLOGIC is not set
# CONFIG_NET_VENDOR_QUALCOMM is not set
# CONFIG_NET_VENDOR_RDC is not set
# CONFIG_NET_VENDOR_REALTEK is not set
# CONFIG_NET_VENDOR_RENESAS is not set
# CONFIG_NET_VENDOR_ROCKER is not set
# CONFIG_NET_VENDOR_SAMSUNG is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
# CONFIG_NET_VENDOR_SMSC is not set
# CONFIG_NET_VENDOR_SOCIONEXT is not set
# CONFIG_NET_VENDOR_SOLARFLARE is not set
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
# CONFIG_NET_VENDOR_SYNOPSYS is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_TOSHIBA is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_NET_VENDOR_XILINX is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_NFC is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
# CONFIG_PARPORT is not set
# CONFIG_PCIE_XILINX is not set
# CONFIG_PHANTOM is not set
# CONFIG_PHY_CADENCE_DPHY is not set
# CONFIG_PHY_CADENCE_SIERRA is not set
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
# CONFIG_PHY_MIXEL_MIPI_DPHY is not set
# CONFIG_PINCTRL is not set
# CONFIG_PLDMFW is not set
# CONFIG_POWER_SUPPLY is not set
# CONFIG_PPC_MAPLE is not set
# CONFIG_PPC_PMAC is not set
# CONFIG_PPC_POWERNV is not set
# CONFIG_PPC_PS3 is not set
# CONFIG_PPS_CLIENT_GPIO is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PTP_1588_CLOCK is not set
# CONFIG_PWM is not set
# CONFIG_QSEMI_PHY is not set
# CONFIG_RAPIDIO is not set
# CONFIG_REALTEK_PHY is not set
# CONFIG_REGULATOR is not set
# CONFIG_RENESAS_PHY is not set
# CONFIG_RFKILL is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
# CONFIG_RTC_DRV_CADENCE is not set
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_HYM8563 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_PCF2127 is not set
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF8523 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_RX8010 is not set
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_SD3078 is not set
# CONFIG_RTC_DRV_X1205 is not set
CONFIG_RTC_I2C_AND_SPI=m
# CONFIG_RTS5208 is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_BNX2X_FCOE is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_EXAR is not set
# CONFIG_SERIAL_8250_FINTEK is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_ICOM is not set
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIO is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_SOUND is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
# CONFIG_SSB is not set
# CONFIG_STAGING_MEDIA is not set
# CONFIG_STE10XP is not set
# CONFIG_TCG_ATMEL is not set
# CONFIG_TCG_TIS is not set
# CONFIG_TCG_TIS_I2C_ATMEL is not set
# CONFIG_TCG_TIS_I2C_INFINEON is not set
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_TPS6507X is not set
# CONFIG_USB_SUPPORT is not set
# CONFIG_VGASTATE is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_VT is not set
# CONFIG_W1 is not set
# CONFIG_WIMAX is not set
# CONFIG_WIRELESS is not set
# CONFIG_WLAN is not set
# CONFIG_XILLYBUS is not set
# CONFIG_XIL_AXIS_FIFO is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
CONFIG_MODULES=y
CONFIG_MODULE_SIG=y
# CONFIG_SUSE_KERNEL_SUPPORTED is not set

--IpbVkmxF4tDyP/Kb--
